#Controllers......................................................
App.controller "CategoryIndexCtrl", ["$scope", "Category", ($scope, Category) ->
  $scope.categories = Category.query()
]

App.controller "CategoryShowCtrl", ["$scope", "$routeParams", "Category", ($scope, $routeParams, Category) ->
  $scope.category = Category.get(id: $routeParams.id)
]

#Services.........................
CategoryServices = angular.module("CategoryServices", ["ngResource"])
CategoryServices.factory "Category", ["$resource", ($resource) ->
  $resource "categories/:id.json", {},
    query:
      method: "GET"
      params:
        id: ""

      isArray: true

]