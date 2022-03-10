angular.module("nobre").controller("SalesController", ["$scope", "Product", function ($scope, Product) {
  $scope.selectedProducts = [];

  // PRODUCTS
  $scope.getProducts = function(filial_id){
    $scope.filial_id = filial_id;

    Product.index({filial_id: $scope.filial_id}).$promise.then(function(response){
      $scope.products = response;
    })
  }

  $scope.setProduct = function(product){
    var index = $scope.selectedProducts.indexOf(product);

    if (index < 0) {
      $scope.selectedProducts.push(product);
      $scope.product = [];
      $('#searchProduct').focus();
    }
  }

  $scope.removeProduct = function(product){
    var index = $scope.selectedProducts.indexOf(product);
    $scope.selectedProducts.splice(index, 1);
  }

  $scope.saveSale = function(){
    var attrs = {
      filial_id: $scope.filial_id, 
      destination_id: $scope.destination_id, 
      destination_filial_id: $scope.destination_filial_id, 
      selectedProducts: $scope.selectedProducts
    }

    Product.order(attrs).$promise.then(function(response){
      if (response.status == 'ok'){
        alert('Estoque atualizado com sucesso!');
        window.location.href = "/filials/"+ $scope.filial_id +"/sales";
      }
    })
  }
}]);
