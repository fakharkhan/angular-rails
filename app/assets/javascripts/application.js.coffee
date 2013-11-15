#Application...............
window.App = angular.module("MyApp", ["ngRoute", 'CategoryServices'])

#Routings..........................................
App.config ["$routeProvider", ($routeProvider) ->
  $routeProvider
  .when("/categories",
    templateUrl: "partials/category-list.html"
    controller: "CategoryIndexCtrl"
  )
  .when("/categories/:id",
    templateUrl: "partials/category-detail.html"
    controller: "CategoryShowCtrl"
  )
  .otherwise redirectTo: "/categories"
]


