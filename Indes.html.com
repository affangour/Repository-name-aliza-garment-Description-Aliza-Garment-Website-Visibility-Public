<!DOCTYPE html>
<html lang="hi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Aliza Garment | Behat</title>

<style>
*{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{font-family:Arial,sans-serif;background:#f6f6f6;color:#222}

header{
  position:sticky;top:0;z-index:1000;
  background:#111;color:#fff;
  padding:15px 5%;
  display:flex;align-items:center;justify-content:space-between;
}
.logo{font-size:25px;font-weight:bold;color:#ffd700}
nav a{color:#fff;text-decoration:none;margin-left:18px}
nav a:hover{color:#ffd700}

.hero{
  min-height:75vh;
  display:flex;align-items:center;justify-content:center;
  text-align:center;color:#fff;padding:30px;
  background:linear-gradient(#0009,#0009),
  url("https://images.unsplash.com/photo-1445205170230-053b83016050?auto=format&fit=crop&w=1600&q=80") center/cover;
}
.hero h1{font-size:55px;margin-bottom:12px}
.hero p{font-size:20px;margin-bottom:25px}

.btn{
  display:inline-block;border:0;cursor:pointer;
  background:#ffd700;color:#111;
  padding:12px 22px;border-radius:25px;
  text-decoration:none;font-weight:bold;margin:5px;
}
.btn:hover{transform:scale(1.04)}

section{padding:55px 6%}
.title{text-align:center;margin-bottom:30px}
.title h2{font-size:34px}
.title p{color:#666;margin-top:8px}

.search{
  max-width:600px;margin:0 auto 30px;
}
.search input{
  width:100%;padding:15px;border:1px solid #ddd;
  border-radius:30px;font-size:16px;outline:none;
}

.categories{text-align:center;margin-bottom:25px}
.categories button{
  padding:10px 18px;margin:5px;border:1px solid #ddd;
  background:#fff;border-radius:20px;cursor:pointer;
}
.categories button:hover{background:#ffd700}

.products{
  display:grid;
  grid-template-columns:repeat(3,1fr);
  gap:22px;
}

.card{
  background:#fff;border-radius:15px;overflow:hidden;
  box-shadow:0 4px 18px #0001;
  transition:.3s;
}
.card:hover{transform:translateY(-6px)}
.card img{width:100%;height:270px;object-fit:cover}
.card-body{padding:18px;text-align:center}
.card-body h3{margin-bottom:7px}
.price{font-size:20px;font-weight:bold;color:#d09f00;margin:10px}

.cart{
  position:fixed;right:20px;bottom:20px;
  z-index:2000;
  background:#111;color:#fff;
  padding:15px 20px;border-radius:30px;
  cursor:pointer;box-shadow:0 5px 20px #0005;
}

.cart span{
  background:#ffd700;color:#111;
  border-radius:50%;padding:3px 8px;margin-left:5px;
}

.cart-box{
  display:none;
  position:fixed;right:20px;bottom:80px;
  width:330px;max-height:70vh;overflow:auto;
  background:#fff;z-index:1999;
  padding:20px;border-radius:15px;
  box-shadow:0 5px 30px #0004;
}

.cart-box h2{text-align:center;margin-bottom:15px}
.cart-item{
  padding:10px 0;border-bottom:1px solid #ddd;
}
.remove{
  color:red;cursor:pointer;font-size:13px;
}
.total{
  font-size:20px;font-weight:bold;
  margin:15px 0;text-align:center;
}

.about{background:#111;color:#fff;text-align:center}
.about p{max-width:800px;margin:auto;line-height:1.8;color:#ddd}

.contact-box{
  max-width:700px;margin:auto;background:#fff;
  padding:30px;text-align:center;border-radius:15px;
  box-shadow:0 4px 18px #0001;
}
.contact-box p{margin:15px 0;font-size:17px}

footer{
  background:#111;color:#fff;text-align:center;padding:25px
}
footer span{color:#ffd700}

.whatsapp{
  position:fixed;left:20px;bottom:20px;
  width:55px;height:55px;border-radius:50%;
  background:#25D366;color:#fff;
  display:flex;align-items:center;justify-content:center;
  text-decoration:none;font-size:25px;z-index:2000;
}

@media(max-width:768px){
  header{flex-direction:column;gap:12px}
  nav a{margin:0 6px;font-size:13px}
  .hero h1{font-size:40px}
  .hero p{font-size:16px}
  .products{grid-template-columns:1fr}
  .cart-box{right:10px;width:calc(100% - 20px)}
}
</style>
</head>

<body>

<header>
  <div class="logo">ALIZA GARMENT</div>
  <nav>
    <a href="#home">Home</a>
    <a href="#products">Products</a>
    <a href="#about">About</a>
    <a href="#contact">Contact</a>
  </nav>
</header>

<section class="hero" id="home">
  <div>
    <h1>Aliza Garment</h1>
    <p>Latest Fashion • Best Collection • Best Price</p>
    <a href="#products" class="btn">Shop Now</a>
    <a href="#contact" class="btn">Contact Us</a>
  </div>
</section>

<section id="products">

<div class="title">
  <h2>Our Products</h2>
  <p>Apni pasand ka product search karein</p>
</div>

<div class="search">
  <input
    type="text"
    id="search"
    placeholder="🔎 Product search karein..."
    onkeyup="searchProducts()">
</div>

<div class="categories">
  <button onclick="filterProducts('all')">All</button>
  <button onclick="filterProducts('ladies')">Ladies</button>
  <button onclick="filterProducts('mens')">Mens</button>
  <button onclick="filterProducts('kids')">Kids</button>
</div>

<div class="products" id="productList">

<div class="card" data-category="ladies" data-name="Ladies Dress">
<img src="https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?auto=format&fit=crop&w=800&q=80">
<div class="card-body">
<h3>Ladies Dress</h3>
<p>Latest ladies collection</p>
<div class="price">₹799</div>
<button class="btn" onclick="addToCart('Ladies Dress',799)">Add to Cart</button>
</div>
</div>

<div class="card" data-category="mens" data-name="Mens Shirt">
<img src="https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?auto=format&fit=crop&w=800&q=80">
<div class="card-body">
<h3>Mens Shirt</h3>
<p>Stylish latest shirt</p>
<div class="price">₹599</div>
<button class="btn" onclick="addToCart('Mens Shirt',599)">Add to Cart</button>
</div>
</div>

<div class="card" data-category="kids" data-name="Kids Fashion">
<img src="https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?auto=format&fit=crop&w=800&q=80">
<div class="card-body">
<h3>Kids Fashion</h3>
<p>Kids latest collection</p>
<div class="price">₹499</div>
<button class="btn" onclick="addToCart('Kids Fashion',499)">Add to Cart</button>
</div>
</div>

<div class="card" data-category="ladies" data-name="Ladies Kurti">
<img src="https://images.unsplash.com/photo-1583391733956-6c78276477e2?auto=format&fit=crop&w=800&q=80">
<div class="card-body">
<h3>Ladies Kurti</h3>
<p>Beautiful stylish kurti</p>
<div class="price">₹699</div>
<button class="btn" onclick="addToCart('Ladies Kurti',699)">Add to Cart</button>
</div>
</div>

<div class="card" data-category="mens" data-name="Mens T Shirt">
<img src="https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=80">
<div class="card-body">
<h3>Mens T-Shirt</h3>
<p>Comfortable fashion wear</p>
<div class="price">₹399</div>
<button class="btn" onclick="addToCart('Mens T-Shirt',399)">Add to Cart</button>
</div>
</div>

<div class="card" data-category="kids" data-name="Kids Dress">
<img src="https://images.unsplash.com/photo-1518831959646-742c3a14ebf7?auto=format&fit=crop&w=800&q=80">
<div class="card-body">
<h3>Kids Dress</h3>
<p>New kids collection</p>
<div class="price">₹449</div>
<button class="btn" onclick="addToCart('Kids Dress',449)">Add to Cart</button>
</div>
</div>

</div>
</section>

<div class="cart" onclick="toggleCart()">
🛒 Cart <span id="cartCount">0</span>
</div>

<div class="cart-box" id="cartBox">
<h2>Your Cart</h2>
<div id="cartItems">Cart empty hai.</div>
<div class="total">Total: ₹<span id="total">0</span></div>

<button class="btn" onclick="orderWhatsApp()">
📲 Order on WhatsApp
</button>
</div>

<section class="about" id="about">
<div class="title">
<h2>About Aliza Garment</h2>
</div>
<p>
Aliza Garment mein aapko latest fashion, stylish designs
aur quality garments milenge. Hamara aim customers ko
achhi quality aur reasonable price par best collection dena hai.
</p>
</section>

<section id="contact">

<div class="title">
<h2>Contact Us</h2>
<p>Hamari shop par visit karein</p>
</div>

<div class="contact-box">
<h2>Aliza Garment</h2>

<p>📍 Maniharan Chowk, Shekpuriyo Wali Gali, Behat</p>

<p>📱 </p>

<p>🕐 10:00 AM – 8:00 PM</p>

<a
class="btn"
href="https://www.google.com/maps/search/?api=1&query=Maniharan+Chowk+Behat"
target="_blank">
📍 Find Location
</a>

<a
class="btn"
href="https://wa.me/"
target="_blank">
💬 WhatsApp
</a>

</div>
</section>

<footer>
<p>© 2026 <span>Aliza Garment</span> | All Rights Reserved</p>
</footer>

<a class="whatsapp"
href="https://wa.me/?text=Hello%20Aliza%20Garment"
target="_blank">
☎
</a>

<script>

let cart = [];

function addToCart(name, price){

  cart.push({name:name, price:price});

  updateCart();

  alert(name + " cart mein add ho gaya!");
}

function updateCart(){

  document.getElementById("cartCount").innerText = cart.length;

  let items = document.getElementById("cartItems");

  if(cart.length === 0){
    items.innerHTML = "Cart empty hai.";
    document.getElementById("total").innerText = "0";
    return;
  }

  let html = "";
  let total = 0;

  cart.forEach((item,index)=>{

    total += item.price;

    html += `
      <div class="cart-item">
        <b>${item.name}</b><br>
        ₹${item.price}
        <br>
        <span class="remove" onclick="removeItem(${index})">
          Remove
        </span>
      </div>
    `;
  });

  items.innerHTML = html;
  document.getElementById("total").innerText = total;
}

function removeItem(index){

  cart.splice(index,1);

  updateCart();
}

function toggleCart(){

  let box = document.getElementById("cartBox");

  if(box.style.display === "block"){
    box.style.display = "none";
  }else{
    box.style.display = "block";
  }
}

function orderWhatsApp(){

  if(cart.length === 0){
    alert("Pehle product cart mein add karein.");
    return;
  }

  let message = "Hello Aliza Garment!%0A%0AMujhe ye products order karne hain:%0A";

  let total = 0;

  cart.forEach(item=>{
    message += "%0A• " + item.name + " - ₹" + item.price;
    total += item.price;
  });

  message += "%0A%0ATotal: ₹" + total;
  message += "%0A%0AName/Address main WhatsApp par bhej dunga.";

  window.open(
    "https://wa.me/?text=" + message,
    "_blank"
  );
}

function searchProducts(){

  let search = document
    .getElementById("search")
    .value
    .toLowerCase();

  let cards = document.querySelectorAll(".card");

  cards.forEach(card=>{

    let name = card
      .getAttribute("data-name")
      .toLowerCase();

    if(name.includes(search)){
      card.style.display = "block";
    }else{
      card.style.display = "none";
    }

  });
}

function filterProducts(category){

  let cards = document.querySelectorAll(".card");

  cards.forEach(card=>{

    if(category === "all" ||
       card.getAttribute("data-category") === category){

      card.style.display = "block";

    }else{

      card.style.display = "none";

    }

  });
}

</script>

</body>
</html>