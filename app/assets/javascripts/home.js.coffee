#Application...............
App = angular.module("MyApp", ["ngRoute", 'CategoryServices'])

#Routings..........................................
App.config ["$routeProvider", ($routeProvider) ->
  $routeProvider.when("/categories",
    templateUrl: "partials/category-list.html"
    controller: "CategoryListCtrl"
  ).when("/categories/:id",
    templateUrl: "partials/category-detail.html"
    controller: "CategoryDetailCtrl"
  ).otherwise redirectTo: "/categories"
]

#Controllers......................................................
App.controller "CategoryListCtrl", ["$scope", "Category", ($scope, Category) ->
  $scope.categories = Category.query()
]

App.controller "CategoryDetailCtrl", ["$scope", "$routeParams", "Category", ($scope, $routeParams, Category) ->
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

