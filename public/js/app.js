// Initialize Firebase

var firebaseConfig = {
  apiKey: "AIzaSyBHtkQEWY5esT86YEAZi2mcKV-C1MvEFr8",
  authDomain: "lanuza-63387.firebaseapp.com",
  databaseURL: "https://lanuza-63387-default-rtdb.firebaseio.com",
  projectId: "lanuza-63387",
  storageBucket: "lanuza-63387.appspot.com",
  messagingSenderId: "40431539801",
  appId: "1:40431539801:web:7db8cea08d1aedbbf48348",
  measurementId: "G-Z31155PZK3"
};

firebase.initializeApp(firebaseConfig);
var db = firebase.firestore();
var today = new Date();
var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
var created_at = date + ' ' + time;




function signup() {

  var username = document.getElementById("username").value;
  username = username.slice(0, 1).toUpperCase() + username.slice(1).toLowerCase();
  var address = document.getElementById("address").value;
  var contact = document.getElementById("mobile").value;
  var gender = document.getElementById("gender").value;
  var email = document.getElementById("email").value;
  var password = document.getElementById("password").value;
  var password2 = document.getElementById("password2").value;

  // check if passwords match
  if (password !== password2) {
    alert("Passwords do not match");
    return false; // prevent form submission
  }

  profile = 'https://static.vecteezy.com/system/resources/previews/002/318/271/original/user-profile-icon-free-vector.jpg'
  var userObj = {
    username,
    email,
    password,
    profile,
    contact,
    gender,
    address,
  }

  console.log(userObj);

  // check if email or username already exist in the database
  db.collection("users").where("email", "==", email)
    .get()
    .then((querySnapshot) => {
      if (!querySnapshot.empty) {
        // email already exists
        window.alert("Email already exists. Please use a different email.");
      } else {
        // email doesn't exist, check username
        db.collection("users").where("username", "==", username)
          .get()
          .then((querySnapshot) => {
            if (!querySnapshot.empty) {
              // username already exists
              window.alert("Username already exists. Please use a different username.");
            } else {
              // email and username don't exist, proceed with sign up
              firebase.auth().createUserWithEmailAndPassword(email, password)
                .then(() => {
                  let userUid = firebase.auth().currentUser.uid;

                  db.collection("users").doc(userUid).set(userObj);
                  firebase.database().ref("users/" + userUid).set(userObj)
                    .then(() => {
                      window.alert("Sign up successfully, Login Now!");
                      document.getElementById("p2").style.display = 'none';
                      swal({
                        type: 'success',
                        title: 'Congratulations!',
                        text: 'Your Account Created Successfully!',
                        confirmButtonText: "Go Login!",
                        confirmButtonColor: "#fa7c6e"
                      }).then((result) => {
                        if (result.value) {
                          window.alert("sometext");
                          location = 'index.html';
                        }
                        else {
                          location = 'index.html';
                        }
                      })
                    })
                    .catch((error) => {
                      window.alert("Wrong username or Password");
                    })
                })
                .catch((error) => {
                  window.alert("Error signing up: " + error.message);
                });
            }
          })
          .catch((error) => {
            window.alert("Error checking username: " + error.message);
          });
      }
    })
    .catch((error) => {
      window.alert("Error checking email: " + error.message);
    });
}

function announcement() {
  var title = document.getElementById("title").value;
  var description = document.getElementById("description").value;

  // Add data to Firestore
  db.collection("Announcement").doc().set({
    Date: created_at,
    Title: title,
    Description: description
  })
    .then(function () {
      console.log("Document successfully written!");

      // Send notification to all phone numbers
      db.collection("Users").get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
          var number = doc.data().phone_number;

          // Send SMS using Twilio API
          var accountSid = "ACe44a6647232d8546914e56818cb93809";
          var authToken = "7dafd98fefebbb4699c7414f9fe6cece";
          var client = require("twilio")(accountSid, authToken);

          client.messages
            .create({
              body: title + ": " + description,
              from: "+18634319648",
              to: '9851486946', // Corrected phone number format
            })

            .then(function (message) {
              console.log("SMS sent to " + number);
            })
            .catch(function (error) {
              console.error("Error sending SMS to " + number + ": ", error);
            });
        });
      });
    })
    .catch(function (error) {
      console.error("Error writing document: ", error);
    });
}






function login() {
  var Email_address = document.getElementById("email").value;
  var password = document.getElementById("password").value;
  firebase.auth().signInWithEmailAndPassword(Email_address, password).then(() => {
    let userUid = firebase.auth().currentUser.uid;

    db.collection("admin").doc(userUid).get().then((doc) => {

      if (doc.exists) {
        window.alert("Login successfully");
        location = './dashboard.html'
      } else {
        window.alert("Login successfully");
        location = 'user/mainscreen.html'
      }

    })
  })
    .catch((error) => {
      window.alert("Wrong username or Password");
    })
}


function uploadImage() {
  var latitude = document.getElementById("latitude").value;
  var longitude = document.getElementById("longitude").value;
  var title = document.getElementById("Title").value;
  var description = document.getElementById("Description").value;

  const image = document.querySelector("#file").files[0];
  const storageRef = firebase.storage().ref();
  const path = storageRef.child("evac/" + image.name);

  path.put(image).then(function (snapshot) {
    snapshot.ref.getDownloadURL().then(function (downloadURL) {
      alert(downloadURL);
      evac(longitude, latitude, title, description, downloadURL);
    });
  });
}
function evac(longitude, latitude, title, description, url) {

  db.collection("locations").doc().set({
    longitude: longitude,
    latitude: latitude,
    title: title,
    description: description,
    photoUrl: url,
  })
    .then(function () {
      var successMsg = "Data added successfully!";
      var successBox = document.createElement("div");
      successBox.setAttribute("class", "success-box");
      successBox.textContent = successMsg;
      document.body.appendChild(successBox);
      setTimeout(function () {
        successBox.style.display = "none";
      }, 3000); // Remove message after 3 seconds
    })
    .catch(function (error) {
      console.error("Error writing document: ", error);
    });
}


function editAnnouncement(docId) {
  const docRef = db.collection("Announcement").doc(docId);

  // Retrieve the current data for the announcement document
  docRef.get().then((doc) => {
    if (doc.exists) {
      // Display a prompt dialog box to get the new values for the announcement
      const newTitle = prompt("Enter the new title for the announcement:", doc.data().Title);
      const newDesc = prompt("Enter the new description for the announcement:", doc.data().Description);

      // If the user clicked the "Cancel" button, do not update the document
      if (newTitle === null || newDesc === null) {
        console.log("Edit cancelled, no changes made.");
        return;
      }

      // Update the announcement document with the new values
      docRef.update({
        Title: newTitle,
        Description: newDesc
      })
        .then(() => {
          console.log("Document successfully updated!");

          // Display a success message to the user
          const successMessage = document.createElement("p");
          successMessage.innerText = "Announcement successfully updated!";
          successMessage.style.color = "green";
          document.body.appendChild(successMessage);

          // Remove the success message after 3 seconds
          setTimeout(() => {
            successMessage.remove();
          }, 3000);
        })
        .catch((error) => {
          console.error("Error updating document: ", error);


          const errorMessage = document.createElement("p");
          errorMessage.innerText = "Error updating announcement. Please try again later.";
          errorMessage.style.color = "red";
          document.body.appendChild(errorMessage);

          setTimeout(() => {
            errorMessage.remove();
          }, 3000);
        });
    } else {
      console.error("No such document!");
    }
  }).catch((error) => {
    console.error("Error getting document: ", error);

    const errorMessage = document.createElement("p");
    errorMessage.innerText = "Error getting announcement. Please try again later.";
    errorMessage.style.color = "red";
    document.body.appendChild(errorMessage);


    setTimeout(() => {
      errorMessage.remove();
    }, 3000);
  });
}




function deleteAnnouncement(docId) {
  db.collection("Announcement").doc(docId).delete()
    .then(() => {
      console.log("Document successfully deleted!");
    })
    .catch((error) => {
      console.error("Error deleting document: ", error);
    });
}





function updateres() {
  var Title = document.getElementById("myInput").value;
  db.collection('help').doc(Title).update({
    status: 'done'
  })
    .then(() => {
      console.log('Document successfully updated!');
      alert('Document successfully updated!');
    })
    .catch((error) => {
      console.error('Error updating document: ', error);
    });
}









//add hotline
function uploadhotline2() {
  var Title = document.getElementById("title").value;
  var number = document.getElementById("number").value;

  const image = document.querySelector("#file").files[0];
  const storageRef = firebase.storage().ref();
  const path = storageRef.child("hotline/" + image.name);

  path.put(image).then(function (snapshot) {
    snapshot.ref.getDownloadURL().then(function (downloadURL) {

      hotline2(Title, number, downloadURL);
    });
  });
}

function hotline2(Title, number, url) {
  db.collection("hotline").doc().set({
    title: Title,
    number: number,
    photoUrl: url,
  })

    .then(function () {
      var successMsg = "Data added successfully!";
      var successBox = document.createElement("div");
      successBox.setAttribute("class", "success-box");
      successBox.textContent = successMsg;
      document.body.appendChild(successBox);
      setTimeout(function () {
        successBox.style.display = "none";
      }, 3000); // Remove message after 3 seconds
    })
    .catch(function (error) {
      console.error("Error writing document: ", error);
    });

}
function imageupdate() {
  var uid = document.getElementById("useruid2").value;

  const image = document.querySelector("#file").files[0];
  const storageRef = firebase.storage().ref();
  const path = storageRef.child("profile/" + image.name);

  path.put(image).then(function (snapshot) {
    snapshot.ref.getDownloadURL().then(function (downloadURL) {

      hotline(uid, downloadURL);
    });
  });
}

function hotline(uid, url) {
  db.collection("users").doc(uid).update({
    profile: url,

  })

    .then(() => {

      alert('Your profile has been updated.');
    })
    .catch(function (error) {
      console.error("Error writing document: ", error);
    });

}

//logout 

function logout() {
  firebase.auth().signOut().then(() => {
    location = 'index.html';
  })
    .catch((error) => {
      swal({
        type: 'error',
        title: 'Something went wrong!',
        text: error.message,
        confirmButtonColor: "rgb(73, 209, 134);"
      })
    })
}
function userlogout() {
  firebase.auth().signOut().then(() => {
    location = '../index.html';
  })
    .catch((error) => {
      swal({
        type: 'error',
        title: 'Something went wrong!',
        text: error.message,
        confirmButtonColor: "rgb(73, 209, 134);"
      })
    })
}
function updateuser() {
  var userId = firebase.auth().currentUser.uid;
  const docRef = db.collection("users").doc(userId);
  var username = document.getElementById("username").value;
  username = username.slice(0, 1).toUpperCase() + username.slice(1).toLowerCase();
  var address = document.getElementById("address").value;
  var contact = document.getElementById("mobile").value;
  var gender = document.getElementById("gender").value;

  if (newTitle === null || newDesc === null) {
    console.log("Edit cancelled, no changes made.");
    return;
  }

  // Update the announcement document with the new values
  docRef.update({
    address: address,
    contact: contact,
    username: username,
    contact: contact,
    gender: gender,

  })
    .then(() => {
      console.log("Document successfully updated!");

      // Display a success message to the user
      const successMessage = document.createElement("p");
      successMessage.innerText = "Announcement successfully updated!";
      successMessage.style.color = "green";
      document.body.appendChild(successMessage);

      // Remove the success message after 3 seconds
      setTimeout(() => {
        successMessage.remove();
      }, 3000);
    })
    .catch((error) => {
      console.error("Error updating document: ", error);


      const errorMessage = document.createElement("p");
      errorMessage.innerText = "Error updating announcement. Please try again later.";
      errorMessage.style.color = "red";
      document.body.appendChild(errorMessage);

      setTimeout(() => {
        errorMessage.remove();
      }, 3000);
    });
}

function updateProfile() {
  var username = document.getElementById("username").value;
  username = username.slice(0, 1).toUpperCase() + username.slice(1).toLowerCase();
  var address = document.getElementById("address").value;
  var contact = document.getElementById("mobile").value;
  var gender = document.getElementById("gender").value;
  var userId = document.getElementById("userid").value;


  db.collection('users').doc(userId).update({
    username: username,
    gender: gender,
    contact: contact,
    address: address
  }).then(() => {
    console.log('Document successfully updated!');
    alert('Your profile has been updated.');
  }).catch((error) => {
    console.error('Error updating document: ', error);
    alert('An error occurred while updating your profile.');
  });

}

function sendsms() { 
  var id = document.getElementById("userid").value;
  var profile = document.getElementById("profile").value;
  var username = document.getElementById("unsame").value;
  var contact = document.getElementById("contact").value;
  var yess = document.getElementById("seniorYes").value;
  var noo = document.getElementById("seniorNo").value;
  var senior = seniorYes.checked ? seniorYes.value : seniorNo.value;
  var message;

  if (senior === 'yes') {
    message = `Emergency alert: ${username} needs your help. Contact ${contact}. There is a senior or PWD who needs assistance.`;
  } else {
    message = `Emergency alert: ${username} needs your help. Contact ${contact}. `;
  }
  
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((position) => {
      const latitude = position.coords.latitude;
      const longitude = position.coords.longitude;
      
      db.collection('help').add({
        latitude: latitude,
        longitude: longitude,
        id: id,
        status: 'pending',
        username: username,
        profile: profile,
        datetime: created_at,
        contact: contact,
        senior: senior,
      }).then(() => {
        console.log('Location successfully sent to Firebase!');
        alert('Your location has been successfully sent.');
        
     
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "https://api.twilio.com/2010-04-01/Accounts/ACa2e42686d6681d1e368091def9b8e070/Messages.json");
        xhr.setRequestHeader("Authorization", "Basic " + btoa("ACa2e42686d6681d1e368091def9b8e070:56896cf1a52cad22c5e3e895c7c2b263"));
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 400) {
            console.log(xhr.responseText);
          }
          else if (xhr.readyState === 4 && xhr.status === 201) {
            console.log("To=" + encodeURIComponent("+639517360070") + "&From=" + encodeURIComponent("+15155265131") + "&Body=" + encodeURIComponent(message));
            console.log("SMS sent successfully.");
            window.location.href = 'mainscreen.html'
          } else if (xhr.readyState === 4 && xhr.status !== 201) {
            console.error("Failed to send SMS. Error code: " + xhr.status);
          }
        };
        xhr.send("To=" + encodeURIComponent("+639517360070") + "&From=" + encodeURIComponent("+15155265131") + "&Body=" + encodeURIComponent(message));
   
      }).catch((error) => {
        console.error('Error storing location: ', error);
      });
    }, (error) => {
      console.error('Error getting current position: ', error);
    });
  } else {
    console.error('Geolocation is not supported by this browser.');
  }
}
