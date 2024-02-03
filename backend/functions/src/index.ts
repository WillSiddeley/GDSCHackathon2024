/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { onRequest } from "firebase-functions/v2/https";
import { firestore } from "firebase-admin";
import * as logger from "firebase-functions/logger";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const uploadImage = onRequest((request, response) => {
    // Retrieve UUID and image URL from the request body
    const userUuid = request.body.userUuid;
    const imageUrl = request.body.imageUrl;
    // Placeholder for number of points gained
    let pointsGained = 10;
    // Get the user reference from the UUID
    const userRef = firestore().collection("users");
    // Increment the user's points
    userRef.doc(userUuid).set({
        points: firestore.FieldValue.increment(pointsGained)
    }, { merge: true });
    // Send a response to the client
    response.send({ "status": "success", "pointsEarned": pointsGained });
    // Log the event
    logger.info(`User ${userUuid} has uploaded an image: ${imageUrl} and earned ${pointsGained} points.`);
});