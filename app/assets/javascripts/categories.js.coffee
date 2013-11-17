#Controllers......................................................
App.controller "CategoryIndexCtrl", ["$location","$scope", "Category", ($location, $scope, Category) ->
  $scope.categories = Category.index()

  $scope.delete = (id) ->
    if confirm("Are you absolutely sure you want to delete?")
      Category.destroy((id: id),(data, getResponseHeaders) ->
        $("#"+id).hide('slow')
      )

]

App.controller "CategoryShowCtrl", ["$scope", "$routeParams", "Category", ($scope, $routeParams, Category) ->
  $scope.category = Category.get(id: $routeParams.id)
]

App.controller "CategoryEditCtrl", ["$location","$scope", "$routeParams", "Category", ($location,$scope, $routeParams, Category) ->
  category = Category.get(id: $routeParams.id)
  $scope.category = category

  $scope.save = ->
    category.$update(id:  $routeParams.id)
    category.$promise.then($location.path("/categories"))

  $scope.isSaveDisabled = ->
    $scope.form.$invalid

]

App.controller "CategoryNewCtrl", ["$location","$scope","Category", ($location,$scope,Category) ->
  $scope.category = new Category({ title: "", description: "",  active: false  })

  $scope.save = ->
    $scope.category.$create((data, getResponseHeaders) ->
      $location.path("/categories")
    )
  $scope.isSaveDisabled = ->
    $scope.form.$invalid

]


#Services.........................
CategoryServices = angular.module("CategoryServices", ["ngResource"])
CategoryServices.factory "Category", ($resource) ->
  $resource("/categories/:id.json", {},
    create:
      method: "POST"

    index:
      method: "GET"
      isArray: true

    update:
      method: "PUT"

    destroy:
      method: "DELETE"
  )

