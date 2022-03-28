angular.module("nobre").controller("ProductsController", ["$scope", "Product", function ($scope, Product) {
  $scope.newProducts = [
    {
      index: 0, 
      isDisabled: false,
      isLocationDisabled: false,
      name: "",
      code: "",
      location: "",
      quantity: "",
      reference: ""
    }
  ];

  // PRODUCTS
  $scope.getProducts = function(filial_id){
    $scope.filial_id = filial_id;

    Product.index({filial_id: $scope.filial_id}).$promise.then(function(response){
      $scope.products = response;
    })
  }

  $scope.setProduct = function(element){
    var product = filter_by($scope.products, 'code', element.code);
    
    if (product){
      element.name = product.name;
      element.location = product.location;
      element.reference = product.reference;
      element.isDisabled = true;

      if (product.location){
        element.isLocationDisabled = true;
      }else{
        element.isLocationDisabled = false;
      }
    }else{
      element.name = "";
      element.location = "";
      element.reference = "";
      element.isDisabled = false;
    }
  }

  $scope.addMore = function(){
    var index = ($scope.newProducts.length)
    var newProduct = {
      index: index, 
      isDisabled: false,
      name: "",
      code: "",
      location: "",
      quantity: "",
      reference: ""
    }

    $scope.newProducts.push(newProduct);
  }

  $scope.removeItem = function(product){
    var index = $scope.newProducts.indexOf(product);
    $scope.newProducts.splice(index, 1);
  }
    
  function filter_by(array, key, value){
    var result = array.filter(function(i){ 
      if(i[key] == value){ 
        return i;
      }
    })

    return result[0];
  }

  $scope.save = function(){
    var attrs = {
      filial_id: $scope.filial_id, 
      products: $scope.newProducts
    }

    Product.save(attrs).$promise.then(function(response){
      if (response.status == 'ok'){
        alert('Estoque atualizado com sucesso!');
        window.location.href = "/filials/"+ $scope.filial_id +"/products";
      }else{
        alert('A Entrada contém errors!');
      }
    })
  }

}]);
