/* global axios*/
var template = document.querySelector("#item");
var objectHolder = document.querySelector(".row");

function addCard() {
  var template = document.querySelector("#item");

  var test = template.content.cloneNode(true);
  var h3tag = test.querySelector("#name");
  h3tag.innerText = "Hello";
  objectHolder.appendChild(test);
  var test1 = template.content.cloneNode(true);
  objectHolder.appendChild(test1);
}

// function testCall() {
axios.get("http://localhost:3000/v3/products").then(function(response) {
  var products = response.data;
  products.forEach(function(product) {
    console.log(product);
    var clone = template.content.cloneNode(true);
    clone.querySelector(".name").innerText = product.name;
    clone.querySelector(".cost").innerText =
      "Cost: " + product.price.toString();
    clone.querySelector(".description").innerText =
      "Description: " + product.description;
    clone.querySelector(".stock").innerText =
      "Stock: " + product.stock.toString();
    objectHolder.appendChild(clone);
  });
});
// }
