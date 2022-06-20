angular.module("nobre").controller("ProductsController", ["$scope", "Product", function ($scope, Product) {  
  $scope.setCategory = function(category){
    $scope.category = category;
    
    $scope.newProducts = [
      {
        index: 0, 
        isDisabled: false,
        isLocationDisabled: false,
        name: "",
        code: "",
        location: "",
        quantity: 1,
        reference: "",
        category: $scope.category,
        created_at: new Date
      }
    ];
  }

  // PRODUCTS
  $scope.getProducts = function(filial_id){
    $scope.filial_id = filial_id;

    Product.index({filial_id: $scope.filial_id, category: $scope.category}).$promise.then(function(response){
      $scope.products = response;
    })
  }

  $scope.setProduct = function(element){
    var code = angular.copy(element.code);
    setTimeout(function(){
      if (code == element.code){
        var product = filter_by($scope.products, 'code', element.code);
        if (product){
          element.name = product.name;
          element.location = product.location;
          element.reference = product.reference;
          element.product_code = product.product_code;
          element.isDisabled = true;
          element.category = $scope.category;
          element.created_at = product.created_at;

    
          if (product.location){
            element.isLocationDisabled = true;
          }else{
            element.isLocationDisabled = false;
          }
        }else{
          // element.name = "";
          // element.location = "";
          // element.reference = "";
          // element.product_code = "";
          element.isDisabled = false;
        }        
      }
    }, 1000);
  }

  $scope.setByProductCode = function(element){
    var code = angular.copy(element.product_code);
    setTimeout(function(){
      if (code == element.product_code && element.product_code != ""){
        var product = filter_by($scope.products, 'product_code', element.product_code);

        if (product){
          element.name = product.name;
          element.location = product.location;
          element.reference = product.reference;
          element.code = product.code;
          element.category = $scope.category;
          element.created_at = $scope.created_at;

          element.isDisabled = true;

          if (product.location){
            element.isLocationDisabled = true;
          }else{
            element.isLocationDisabled = false;
          }
          element.$apply;
        }else{
          // element.name = "";
          // element.location = "";
          // element.reference = "";
          // element.code = "";
          element.isDisabled = false;
        }
      }
    }, 500);
  }

  $scope.addMore = function(){
    var index = ($scope.newProducts.length)
    var newProduct = {
      index: index, 
      isDisabled: false,
      name: "",
      code: "",
      product_code: "",
      location: "",
      quantity: 1,
      reference: "",
      category: $scope.category,
      created_at: new Date
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

        if($scope.category == 'item'){
          window.location.href = "/filials/"+ $scope.filial_id +"/products";
        }else{
          window.location.href = "/filials/"+ $scope.filial_id +"/epis";
        }
      }else{
        alert('A Entrada contém errors!');
      }
    })
  }

}]);
