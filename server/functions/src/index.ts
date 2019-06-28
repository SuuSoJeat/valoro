import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { COL_USERS, COL_DASHBOARD, DOC_BALANCES, defaultDashboardBalances } from './constants';

admin.initializeApp()

export const userInitializer = functions.auth.user().onCreate(async (user, context) => {
    try {
        const initialization = await admin.firestore()
            .collection(COL_USERS)
            .doc(user.uid)
            .collection(COL_DASHBOARD)
            .doc(DOC_BALANCES)
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
