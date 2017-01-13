/**
 * Created by DrCraig LawPav on 1/12/2017.
 */
var nodemailer = require('nodemailer');

exports.send = function (data,next) {
// create reusable transporter object using the default SMTP transport
  var transporter = nodemailer.createTransport('smtps://atlanticsolicitors01@gmail.com:Solicitors01@smtp.gmail.com');

// setup e-mail data with unicode symbols
  var mailOptions = {
    from: '"Atlantic Solicitors" <contact@atlanticsolicitors.com>', // sender address
    to: data.to, // list of receivers
    subject: data.subject, // Subject line
    html: data.reply // html body
  };

// send mail with defined transport object
  transporter.sendMail(mailOptions, function(error, info){
    if(error){
      return next(error);
    }
    return next(info);
  });
};



