<h1 align="center">🧭 JIHC Lost and Found</h1>
<p align="center"><em>A mobile application to help students and staff easily find or report lost items at JIHC.</em></p>

<hr>

<h2>🚀 Overview</h2>
<p><strong>JIHC Lost and Found</strong> simplifies how users report and discover missing items.
Built using <strong>Flutter</strong>, <strong>Bloc</strong>, and <strong>Dio</strong>, the app connects to a backend API for authentication, posting, and real-time messaging.</p>

<hr>

<h2>🧩 Tech Stack</h2>
<table>
  <tr><th>Layer</th><th>Technology</th></tr>
  <tr><td><strong>Frontend</strong></td><td>Flutter</td></tr>
  <tr><td><strong>State Management</strong></td><td>Bloc</td></tr>
  <tr><td><strong>Networking</strong></td><td>Dio</td></tr>
  <tr><td><strong>Local Storage</strong></td><td>Shared Preferences</td></tr>
  <tr><td><strong>Backend Communication</strong></td><td>REST API</td></tr>
</table>

<hr>

<h2>🔐 Login & Registration</h2>

<div align="center" style="display:flex; gap:10px; justify-content:center; align-items:center">
  <img src="https://github.com/user-attachments/assets/3df21cea-8188-4afd-b45c-022ae7590d88" width="250" alt="Login">
  <img src="https://github.com/user-attachments/assets/d9d58581-8e34-4799-a726-3a6c5eaf56d5" width="250" alt="Register">
</div>

<ul>
  <li>Users can <strong>register</strong> and <strong>log in</strong> with credentials.</li>
  <li>On successful login, the API returns:
    <ul>
      <li>Access Token</li>
      <li>User ID</li>
      <li>Username</li>
    </ul>
  </li>
  <li>Credentials are securely stored with <strong>Shared Preferences</strong>.</li>
</ul>

<hr>

<h2>🏠 Home Page</h2>

<div align="center" style="display:flex; gap:10px; justify-content:center; align-items:center">
  <img src="https://github.com/user-attachments/assets/7f065813-473f-4526-b11d-a13f3fa2c002" width="230" alt="Grid View">
  <img src="https://github.com/user-attachments/assets/e5cf9e19-a0a3-444a-b22b-cf1fd260ddaa" width="230" alt="List View">
  <img src="https://github.com/user-attachments/assets/ba57bb50-52ae-46b5-9829-836505b0c562" width="230" alt="Filtered">
</div>

<ul>
  <li>Displays <strong>unresolved (unfound)</strong> items.</li>
  <li>Switch between <strong>grid</strong> and <strong>list</strong> layouts.</li>
  <li>Filter by <strong>Lost</strong> or <strong>Found</strong>.</li>
  <li><strong>Search bar</strong> for quick item lookup.</li>
</ul>

<hr>

<h2>🧾 Item Details</h2>

<div align="center">
  <img src="https://github.com/user-attachments/assets/a90bb5e2-e2ad-405f-8dbf-110c533afc3c" width="300" alt="Item Details">
</div>

<ul>
  <li>View full item information.</li>
  <li>Start a <strong>direct chat</strong> with the person who posted the item.</li>
</ul>

<hr>

<h2>📦 Post Item</h2>

<div align="center" style="display:flex; gap:10px; justify-content:center; align-items:center">
  <img src="https://github.com/user-attachments/assets/de3fc8ea-4cf9-40cd-a935-f2ab599e9c34" width="230" alt="Post Item">
  <img src="https://github.com/user-attachments/assets/abc5143f-f173-4ada-b6b8-b2e5d0bd5c61" width="230" alt="Preview">
</div>

<ul>
  <li>Users can <strong>post new lost or found items</strong>.</li>
  <li>Uploading an image displays it instantly in the container.</li>
  <li>Posts are sent directly to the API.</li>
</ul>

<hr>

<h2>💬 Direct Messages</h2>

<div align="center" style="display:flex; gap:10px; justify-content:center; align-items:center">
  <img src="https://github.com/user-attachments/assets/346ec072-d4e3-4890-90c1-4e6b3bdf6b04" width="230" alt="Chats">
  <img src="https://github.com/user-attachments/assets/bae35b24-2d7d-4106-b9fe-b3b4607f8610" width="230" alt="Messages">
</div>

<ul>
  <li>Users can <strong>chat directly</strong> with others.</li>
  <li>The <strong>“Resolved”</strong> button:
    <ul>
      <li>Marks the item as found.</li>
      <li>Deletes the chat.</li>
      <li>Redirects to the main page.</li>
    </ul>
  </li>
</ul>

<hr>

<h2>👤 Profile</h2>

<div align="center">
  <img src="https://github.com/user-attachments/assets/db2c5217-b397-47cd-b499-c73f271ace38" width="260" alt="Profile">
</div>

<ul>
  <li>Displays all items posted by the user.</li>
  <li>Ability to <strong>resolve</strong> or <strong>delete</strong> items.</li>
</ul>

<hr>

<h2>⚙️ Features Summary</h2>

<ul>
  <li>✅ User Authentication</li>
  <li>✅ API Integration (Dio)</li>
  <li>✅ Persistent Storage</li>
  <li>✅ Item Filtering & Search</li>
  <li>✅ Real-Time Messaging</li>
  <li>✅ Profile Management</li>
  <li>✅ Image Upload</li>
</ul>

<hr>

<h2>🧠 Architecture</h2>

<p>The app follows <strong>Clean Architecture</strong> principles:</p>
<ul>
  <li><strong>Data Layer:</strong> API integration via Dio</li>
  <li><strong>Logic Layer:</strong> Bloc state management</li>
  <li><strong>Presentation Layer:</strong> Responsive Flutter UI</li>
</ul>

<hr>

<h2>📱 Future Improvements</h2>
<ul>
  <li>Push notifications for new messages</li>
  <li>Integration with Firebase Storage</li>
  <li>Improved image compression and preview</li>
  <li>Dark mode</li>
</ul>

<hr>

<h2>👑 Author</h2>

<p><strong>Batu</strong> — Flutter Developer<br>
📍 <em>JIHC, Kazakhstan</em><br>
💬 <em>Built with love using Flutter 💙</em></p>
