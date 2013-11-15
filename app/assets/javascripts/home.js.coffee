app = angular.module("MyApp", ["ngRoute", "CategoryControllers"])

#Routings..........................................
app.config ["$routeProvider", ($routeProvider) ->
  $routeProvider.when("/categories",
    templateUrl: "partials/category-list.html"
    controller: "Index"
  ).when("/categories/:id",
    templateUrl: "partials/category-detail.html"
    controller: "Show"
  ).otherwise redirectTo: "/categories"
]


CategoryControllers = angular.module("CategoryControllers", [])

CategoryControllers.controller "Index", ["$scope", "$http", ($scope, $http) ->
  $http.get("http://localhost:3000/categories.json").success ((data) ->
    $scope.categories = data
  )
]

CategoryControllers.controller "Show", ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->
  $http.get("http://localhost:3000/categories/"+$routeParams.id+".json").success ((data) ->
    $scope.category = data
  )
]


