# JIHC Lost and Found

An application to assist people on finding their items.
Application is done using these main libraries:
Bloc and Dio
# Login and Register

<div style="display:flex">
  <img width="398" height="771" alt="image" src="https://github.com/user-attachments/assets/3df21cea-8188-4afd-b45c-022ae7590d88" />
  <img width="359" height="769" alt="image" src="https://github.com/user-attachments/assets/d9d58581-8e34-4799-a726-3a6c5eaf56d5" />
</div>

Login and Registration send a Post request to API.
Login request responds with:
Access key,
userId,
userName.
The information is stored using Shared Preferences.

# HomePage

<div style="display:flex">
  <img width="374" height="771" alt="image" src="https://github.com/user-attachments/assets/7f065813-473f-4526-b11d-a13f3fa2c002" />
  <img width="377" height="768" alt="image" src="https://github.com/user-attachments/assets/e5cf9e19-a0a3-444a-b22b-cf1fd260ddaa" />
  <img width="376" height="769" alt="image" src="https://github.com/user-attachments/assets/ba57bb50-52ae-46b5-9829-836505b0c562" />
</div>

Homepage shows items which are not resolved (Not found) and click on the layout buttons changes the layout of tiles. 
Filtering buttons filter items by their type (Lost or Found).
Search filters items by their name 

# Item Detail

<div style="display:flex">
  <img width="446" height="764" alt="image" src="https://github.com/user-attachments/assets/a90bb5e2-e2ad-405f-8dbf-110c533afc3c" />
</div>

By clicking to one item you can get to the details of the item and you can start a chat to communicate with founder of item.

# Post

<div style="display:flex">
  <img width="297" height="619" alt="image" src="https://github.com/user-attachments/assets/de3fc8ea-4cf9-40cd-a935-f2ab599e9c34" />
  <img width="296" height="618" alt="image" src="https://github.com/user-attachments/assets/abc5143f-f173-4ada-b6b8-b2e5d0bd5c61" />
</div>

Post page sends a posts an item to API. Dropping the image results in displaying the image in the container.

# Direct Messages

<div style="display:flex">
 <img width="445" height="715" alt="image" src="https://github.com/user-attachments/assets/346ec072-d4e3-4890-90c1-4e6b3bdf6b04" />
 <img width="331" height="772" alt="image" src="https://github.com/user-attachments/assets/bae35b24-2d7d-4106-b9fe-b3b4607f8610" />
</div>

Two users can send messages to eachother, also pressing the resolved button deletes chat and redirects to main page.

# Profile

<div style="display:flex">
  <img width="444" height="769" alt="image" src="https://github.com/user-attachments/assets/db2c5217-b397-47cd-b499-c73f271ace38" />
  <img width="417" height="171" alt="image" src="https://github.com/user-attachments/assets/c559651e-57a9-4904-b8a4-1a2664416590" />
</div>

Profile page display items of user and can resolve or delete items.
