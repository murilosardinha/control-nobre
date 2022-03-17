angular.module("nobre").factory("Sale", ["$resource", function ($resource) {
  return $resource("/api/sales?&format=json", {}, {
    show: { isArray: true, url:"/api/sales?&format=json", method: "GET" },
    receive: { isArray: false, url:"/api/sales?&format=json", method: "POST" },
  })
}]);
