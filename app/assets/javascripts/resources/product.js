angular.module("nobre").factory("Product", ["$resource", function ($resource) {
  return $resource("/api/products?&format=json", {}, {
    index: { isArray: true, url:"/api/products?&format=json", method: "GET" },
    order: { isArray: false, url:"/api/products?&format=json", method: "POST" }
  })
}]);
