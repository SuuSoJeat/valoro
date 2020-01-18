import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { COL_USERS, COL_DASHBOARD, COL_DEBTS, COL_RECORDS, defaultDashboardBalances } from './constants';

admin.initializeApp()

export const userInitializer = functions.auth.user().onCreate(async (user, context) => {
    try {
        const initialization = await admin.firestore()
            .collection(COL_DASHBOARD)
            .doc(user.uid)
            .create(defaultDashboardBalances)
        console.info(`Successfully initialized a new user ${user.uid} at ${initialization.writeTime.toDate()}`)
    } catch (error) {
        console.error(`Failed to initialize a new user ${user.uid} due to ${error.message}. Context ${context}`)
    }
})

export const userRemover = functions.auth.user().onDelete(async (user, context) => {
    try {
        const destruction = await admin.firestore().collection(COL_USERS).doc(user.uid).delete()
        console.info(`Successfully removed user ${user.uid} from Firestore at ${destruction.writeTime.toDate()}.`)
    } catch (error) {
        console.error(`Failed to remove user ${user.uid} from Firestore.`)
    }
})

export const createNewDebt = functions.https.onCall(async (data, context) => {
    if (context.auth === undefined) {
        throw new functions.https.HttpsError("unauthenticated", "The function must be called while authenticated.")
    }
    const uid = context.auth.uid
    try {
        console.info('Getting input data.')
        const debtorName: string = data.debtorName
        const debtorUID: string = data.debtorUID
        const description: string = data.description

        const amount: number = data.amount
        const currency: string = data.currency
        const debtType: string = data.debtType
        const issueDate: string = data.issueDate
        console.info(`Input data: uid ${uid}, debtorName ${debtorName}, description ${description}, amount ${amount}, currency ${currency}, debtType ${debtType}, issueDate ${issueDate}.`)

        console.info('Creating a new debt.')
        const debtDocRef = await admin.firestore().collection(COL_DEBTS).add({
            uid: uid,
            debtorName: debtorName,
            debtorUID: debtorUID,
            description: description,
            totalDebt: numericBasedConvert(debtType, amount), //TODO: Normalize the currency
            totalLent: isLending(debtType, amount), //TODO: Normalize the currency
            totalBorrowed: isBorrowing(debtType, amount), //TODO: Normalize the currency
            createdAt: new Date(),
            updatedAt: new Date()
        })
        console.info(`Successfully created a new debt with ID ${debtDocRef.id}`)

        const recordDocRef = await admin.firestore().collection(COL_RECORDS).add({
            uid: uid,
            debtID: debtDocRef.id,
            amount: amount,
            debtType: debtType,
            currency: currency,
            issueDate: new Date(issueDate),
            createdAt: new Date()
        })
        console.info(`Successfully created a new record with ID ${recordDocRef.id}`)
        return {
            debtDocId: debtDocRef.id,
            recordDocId: recordDocRef.id
        }
    } catch (error) {
        console.error(`Failed to create a new debt for following reasons: ${error}.`)
        throw new functions.https.HttpsError("internal", `Failed to create a new debt.`, error)
    }
    function isLending(debtType: string, amount: number): number { return debtType === 'lending' ? -amount : 0 }
    function isBorrowing(debtType: string, amount: number): number { return debtType === 'borrowing' ? amount : 0 }
    function numericBasedConvert(debtType: string, amount: number): number { return debtType === 'lending' ? -amount : amount }
})

