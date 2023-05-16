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
window.addEventListener("load", async function loader() {
  await load();
})

firebase.initializeApp(firebaseConfig);
var db = firebase.firestore();
var today = new Date();
var date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();
var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
var created_at = date + ' ' + time;


async function load() {
  await firebase.auth().onAuthStateChanged(function (user) {

    if (user) {

      var userId = firebase.auth().currentUser.uid;

    

      db.collection("users").doc(userId).get().then(function (doc) {
        if (doc.exists) {
          var userId = firebase.auth().currentUser.uid;
          document.getElementById("uname").innerHTML = doc.data().username;
          var profileImage = doc.data().profile;
          document.getElementById("useruid2").value = userId;
          document.getElementById("uprofile").src = profileImage;

 document.getElementById("editprof").src = profileImage;

          document.getElementById("useruid").value = userId;
          document.getElementById("profile").value = profileImage;
          document.getElementById("unsame").value = doc.data().username;
          document.getElementById("contact").value = doc.data().contact;

 
        }
      }).catch(function (error) {
        console.log("Error getting document:", error);
      });


      db.collection('users').doc(userId).get().then((doc) => {
        if (doc.exists) {
          const data = doc.data();
          document.getElementById('username').value = data.username;
          document.getElementById('userid').value = userId;
          document.getElementById('gender').value = data.gender;
          document.getElementById('mobile').value = data.contact;
          document.getElementById('address').value = data.address;
        } else {
          console.log('No such document!');
        }
      }).catch((error) => {
        console.log('Error getting document:', error);
      });
      firebase.database().ref("users/" + userId).once("value").then((data) => {
        let alert = data.val();
        document.getElementById("uname").innerHTML = alert.username;
        document.getElementById("Gender").innerHTML = alert.Gender;


      })
      db.collection("help").where("status", "==", "pending").get().then(function (querySnapshot) {
        document.getElementById("counter-count2").textContent = querySnapshot.size;
      });


      db.collection("users").get().then(function (querySnapshot) {
        document.getElementById("counter-count").textContent = querySnapshot.size;
      });


      db.collection("help").where("status", "==", "done").get().then(function (querySnapshot) {
        document.getElementById("counter-count3").textContent = querySnapshot.size;
      });
      //-------------total user
      const tableData = document.querySelector('#table-data1');


      db.collection('users').get().then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          const user = doc.data();
          const row = document.createElement('tr');

          const nameCell = document.createElement('td');
          const profileImage = document.createElement('img');
          profileImage.src = user.profile;
          nameCell.appendChild(profileImage);
          row.appendChild(nameCell);


          const emailCell = document.createElement('td');
          emailCell.textContent = user.username;
          row.appendChild(emailCell);

          const ageCell = document.createElement('td');
          ageCell.textContent = user.age;
          row.appendChild(ageCell);
          const addcell = document.createElement('td');
          addcell.textContent = user.address;
          row.appendChild(addcell);
          const concell = document.createElement('td');
          concell.textContent = user.contact;
          row.appendChild(concell);




          tableData.appendChild(row);
        });
      });
      //-----------------------------------------------total evac

      const tableData2 = document.querySelector('#table-data2');


      db.collection('help').where("status", "==", "pending").get().then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          const user = doc.data();
          const row = document.createElement('tr');

          const nameCell = document.createElement('td');
          const profileImage = document.createElement('img');
          profileImage.src = user.profile;
          nameCell.appendChild(profileImage);
          row.appendChild(nameCell);
          const username = document.createElement('td');
          username.textContent = user.username;
          row.appendChild(username);
          const concell = document.createElement('td');
          concell.textContent = user.contact;
          row.appendChild(concell);

          const latitude = document.createElement('td');
          latitude.textContent = user.latitude;
          row.appendChild(latitude);

          const longitude = document.createElement('td');
          longitude.textContent = user.longitude;
          row.appendChild(longitude);

          const emailCell = document.createElement('td');
          emailCell.textContent = user.senior;
          row.appendChild(emailCell);
          const statusCell = document.createElement('td');
          statusCell.textContent = user.status;
          statusCell.className = "statusCell";
          row.appendChild(statusCell);


          row.addEventListener('click', () => {

            window.location.href = 'table.html?name=' + user.senior + '&latitude=' + user.latitude + '&longitude=' + user.longitude + '&contact=' + user.contact + '&username=' + user.username;
          });


          tableData2.appendChild(row);
        });
      });
      //---------------------- done request -----------------
      const tableData3 = document.querySelector('#table-data3');


      db.collection("help").where("status", "==", "done").get().then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          const user = doc.data();
          const row = document.createElement('tr');

          const nameCell = document.createElement('td');
          const profileImage = document.createElement('img');
          profileImage.src = user.profile;
          nameCell.appendChild(profileImage);
          row.appendChild(nameCell);
          const username = document.createElement('td');
          username.textContent = user.username;
          row.appendChild(username);
          const concell = document.createElement('td');
          concell.textContent = user.contact;
          row.appendChild(concell);

          const latitude = document.createElement('td');
          latitude.textContent = user.latitude;
          row.appendChild(latitude);

          const longitude = document.createElement('td');
          longitude.textContent = user.longitude;
          row.appendChild(longitude);

          const emailCell = document.createElement('td');
          emailCell.textContent = user.senior;
          row.appendChild(emailCell);
          const doneCell = document.createElement('td');
          doneCell.className = "doneCell";
          doneCell.textContent = user.status;
          row.appendChild(doneCell);

          row.addEventListener('click', () => {

            window.location.href = 'table.html?name=' + user.senior + '&latitude=' + user.latitude +
              '&longitude=' + user.longitude;
            '&contact=' + user.user.contact;
            '&profile=' + user.user.profile;
            '&username=' + user.username;
          });


          tableData3.appendChild(row);
        });
      });


      //------------------------------------------------hotline------------
      const hotlineData = document.querySelector('#hotline');


      db.collection('help').get().then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          const user = doc.data();
          const row = document.createElement('tr');

          const nameCell = document.createElement('td');
          nameCell.textContent = user.latitude;
          row.appendChild(nameCell);

          const ageCell = document.createElement('td');
          ageCell.textContent = user.longitude;
          row.appendChild(ageCell);

          const emailCell = document.createElement('td');
          emailCell.textContent = user.id;
          row.appendChild(emailCell);


          row.addEventListener('click', () => {

          });


          hotlineData.appendChild(row);
        });
      });
      //--------------------------------------------hotline2



      const announcementsRef = db.collection("Announcement");
      function editAnnouncement(id) {

        const announcementRef = announcementsRef.doc(id);
        announcementRef.get().then(function (doc) {

          const announcementData = doc.data();


          document.getElementById("edit-title").value = announcementData.Title;
          document.getElementById("edit-description").value = announcementData.Description;
          document.getElementById("edit-announcement-modal").style.display = "block";
          document.getElementById("edit-announcement-id").value = id;
        });
      }
      function deleteAnnouncement(id) {
        const announcementRef = announcementsRef.doc(id);
        const confirmDelete = confirm("Are you sure you want to delete this announcement?");

        if (confirmDelete) {
          announcementRef.delete();
        }
      }


      announcementsRef.onSnapshot(function (querySnapshot) {
        document.getElementById("post").innerHTML = "";
        querySnapshot.forEach(function (doc) {

          const announcementData = doc.data();


          const announcementHTML = `
        <div class="Posted" id="Posted-${doc.id}">
          <div class="announcement-content">
            <h4 class="titles">${announcementData.Title}</h4>
            <p class="datetime">${date},${time}</p>
            <p class="desc">${announcementData.Description}</p>
          </div>
     
          <div class="announcement-buttons">
            <button class="edit-button" onclick="editAnnouncement('${doc.id}')">Edit</button>
            <button class="delete-button" onclick="deleteAnnouncement('${doc.id}')">Delete</button>
          </div>
        </div>
      `;

          // Add the HTML for the current announcement to the "post" div element
          document.getElementById("post").insertAdjacentHTML("beforeend", announcementHTML);
        });

      });


      announcementsRef.onSnapshot(function (querySnapshot) {
        document.getElementById("postuser").innerHTML = "";
        querySnapshot.forEach(function (doc) {

          const announcementData = doc.data();


          const announcementHTML = `
        <div class="Posted" id="Posted-${doc.id}">
          <div class="announcement-content" >
            <h2 class="titles">${announcementData.Title}</h2>
            <p class="datetime">${date},${time}</p>
            <p class="desc">${announcementData.Description}</p>
          </div>
         
        </div>
      `;

          // Add the HTML for the current announcement to the "post" div element
          document.getElementById("postuser").insertAdjacentHTML("beforeend", announcementHTML);
        });

      });


      const hotlinedata = document.querySelector('.hotlinedata');

      // Get a reference to the Firestore collection
      const hotlineCollection = db.collection('hotline');

      // Fetch the data from Firestore
      hotlineCollection.get().then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          // Get the data for each document
          const data = doc.data();
          const id = doc.id;

          // Create the HTML elements for the data
          const titleEl = document.createElement('h3');
          titleEl.textContent = data.title;

          const numberEl = document.createElement('div');
          numberEl.textContent = data.number;

          const photoEl = document.createElement('img');
          photoEl.src = data.photoUrl;

          // Add the HTML elements to the hotlinedata container
          const hotlinedataEl = document.createElement('div');
          hotlinedataEl.classList.add('hotline-item');
          hotlinedataEl.appendChild(photoEl);
          hotlinedataEl.appendChild(titleEl);
          hotlinedataEl.appendChild(numberEl);

          // Add edit and delete buttons
          const editBtn = document.createElement('button');
          editBtn.textContent = 'Edit';
          editBtn.addEventListener('click', () => {
            // Handle edit button click
            const newTitle = prompt('Enter new title:', data.title);
            const newNumber = prompt('Enter new number:', data.number);

            if (newTitle && newNumber) {
              hotlineCollection.doc(id).update({
                title: newTitle,
                number: newNumber
              }).then(() => {
                console.log('Document updated successfully');
              }).catch((error) => {
                console.error('Error updating document:', error);
              });
            }
          });
          hotlinedataEl.appendChild(editBtn);

          const deleteBtn = document.createElement('button');
          deleteBtn.textContent = 'Delete';
          deleteBtn.addEventListener('click', () => {

            const confirmDelete = confirm("Are you sure you want to delete this hotline?");

            if (confirmDelete) {


              hotlineCollection.doc(id).delete().then(() => {
                console.log('Document deleted successfully');
              }).catch((error) => {
                console.error('Error deleting document:', error);
              });
            }

          });
          hotlinedataEl.appendChild(deleteBtn);

          hotlinedata.appendChild(hotlinedataEl);
        });
      });


      var userId = firebase.auth().currentUser.uid;
      var myInput = document.getElementById("userid");
      myInput.value = userId;
      
      
    }
    const userhotline = document.getElementById('userhotline');

    db.collection('hotline').get().then((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        const data = doc.data();

        const number = data.number;
        const photoUrl = data.photoUrl;
        const title = data.title;

        const card = document.createElement('div');
        card.className = 'hotline_card';

        const imageContainer = document.createElement('div');
        imageContainer.className = 'image_container';

        const image = document.createElement('img');
        image.src = photoUrl;
        image.style.width = '80px'; // set width of image to 150px

        const titleElement = document.createElement('h2');
        titleElement.textContent = title;

        const numberElement = document.createElement('p');
        numberElement.textContent = ` ${number}`;

        imageContainer.appendChild(image);
        card.appendChild(imageContainer);
        card.appendChild(titleElement);
        card.appendChild(numberElement);

        userhotline.appendChild(card);
      });
    }).catch((error) => {
      console.error('Error getting hotlines: ', error);
    });



  })

}    
