angular.module("nobre").controller("SalesController", ["$scope", "Product", "Sale", function ($scope, Product, Sale) {
  $scope.selectedProducts = [];
  $scope.destination_id = 0;

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
    }
    $scope.product = [];
    $('#searchProduct').focus();
  }

  $scope.removeProduct = function(product){
    var index = $scope.selectedProducts.indexOf(product);
    $scope.selectedProducts.splice(index, 1);
  }

  $scope.saveSale = function(){
    var attrs = {
      filial_id: $scope.filial_id, 
      sale_id: $scope.sale_id,
      destination_id: $scope.destination_id, 
      destination_filial_id: $scope.destination_filial_id, 
      selectedProducts: $scope.selectedProducts
    }

    Product.order(attrs).$promise.then(function(response){
      if (response.status == 'ok'){
        alert('Estoque atualizado com sucesso!');
        window.location.href = "/filials/"+ $scope.filial_id +"/sales";
      }else{
        alert('A Baixa contém errors!');
      }
    })
  }

  $scope.checkNumber = function(product){
    var max = product.quantity;
    var value = product.qtd_to_sale;

    if (value > max){
      $('#qdt_'+ product.id).val(max)
    }else if(value == undefined ){
      $('#qdt_'+ product.id).val(max)
    }
  }

  // ENTRANCES
  $scope.getSale = function(filial_id, id, entrance = false){
    $scope.filial_id = filial_id;
    $scope.sale_id = id;
    $scope.entrance = entrance;

    Sale.show({filial_id: $scope.filial_id, id: $scope.sale_id, entrance: $scope.entrance}).$promise.then(function(response){
      if ($scope.entrance == true){
        $scope.saleProducts = response;
      }else{
        $scope.selectedProducts = response
      }
    })

  }

  $scope.setProductSale = function(saleProduct){
    $scope.setProduct(saleProduct);

    var index = $scope.saleProducts.indexOf(saleProduct);
    $scope.saleProducts.splice(index, 1);
  }

  $scope.removeProductSale = function(saleProduct){
    $scope.removeProduct(saleProduct);
    $scope.saleProducts.push(saleProduct);
  }

  $scope.receiveSale = function(){
    var checked_products = [];

    for(var i = 0; i < $scope.selectedProducts.length; i++){
      checked_products.push({
        id: $scope.selectedProducts[i].id,
        location: $scope.selectedProducts[i].current_location,
      })
    }

    Sale.receive({filial_id: $scope.filial_id, id: $scope.sale_id, checked_products: checked_products}).$promise.then(function(response){
      if (response.status == 'ok'){
        alert('Estoque atualizado com sucesso!');
        window.location.href = "/filials/"+ $scope.filial_id +"/products";
      }else{
        alert('O Recebimento foi feito parcialmente!');
        window.location.href = "/filials/"+ $scope.filial_id +"/products";
      }
    })
  }
}]);
