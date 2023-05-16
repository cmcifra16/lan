const { Vonage } = require('@vonage/server-sdk')

const vonage = new Vonage({
  apiKey: "814b99ad",
  apiSecret: "w5sVklcPrI2GjVwR"
})
const from = "Lanuza"
const to = "639851486946"
const text = 'A text message sent using the Vonage SMS API'

async function sendSMS() {
    await vonage.sms.send({to, from, text})
        .then(resp => { console.log('Message sent successfully'); console.log(resp); })
        .catch(err => { console.log('There was an error sending the messages.'); console.error(err); });
}

sendSMS();