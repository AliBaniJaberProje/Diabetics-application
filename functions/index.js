const functions = require("firebase-functions");
const admin = require("firebase-admin");
// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

admin.initializeApp(functions.config().functions);


// exports.notificationtrigar=functions.database.ref("chat/{s}").onCreate(
//    async (snp,context)=>{
//
//         var payload={notification:{title:"رسالة جديدة من طبيبك ",body:snp.toJSON().toString(),},
//           data:{click_action:"FLUTTER_NOTIFICATION_CLICK"},
//
//         }
//     const  res= await admin.messaging().sendToTopic('chat',payload);
//
//     }
// )
//
// exports.notificationtrigar2=functions.database.ref("testnot/{s}").onCreate(
//     async (snp,context)=>{
//
//
//         var payload={notification:{title:"رسالة جديدة ",body:"test.toString()",},
//             data:{click_action:"FLUTTER_NOTIFICATION_CLICK"}
//         }
//         const  res= await admin.messaging().sendToTopic('testnot',payload);
//
//     }
// )
// exports.notificationTrigarMsg=functions.database.ref("notification_msg/{notification}").onCreate(
//     async (snp,context)=>{
//
//
//         var payload={notification:{title:"رسالة جديدة ",body:snp.toJSON()["text"].toString(),},
//             data:{click_action:"FLUTTER_NOTIFICATION_CLICK"}
//         }
//         const  res= await admin.messaging().sendToTopic('notification_msg',payload);
//
//     }
// )

exports.notificationTrigarMsg2=functions.database.ref("pushNotification/{notification}").onCreate(
    async (snp,context)=>{
        var tokent=[];
        tokent.push(snp.toJSON()["token"].toString());
                var payload={notification:{title:snp.toJSON()["title"].toString(),body:snp.toJSON()["token"].toString(),},
            data:{click_action:"FLUTTER_NOTIFICATION_CLICK"}
        }
        const  res= await admin.messaging().sendToDevice(tokent,payload);

      //  const  res= await admin.messaging().sendToTopic('pushNotifications',payload);

    }
)



// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
