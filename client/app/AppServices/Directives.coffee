angular.module 'atlanticSolicitorsApp'
.directive 'mixitup', ($compile) ->
  restrict: 'A'
  scope:
    datasource: '='
    add: '&'
  link: (scope, element, attrs) ->
    scope.$on 'init-mixitup', (event) ->
      console.log 'init'
      angular.element(element).mixItUp
        animation: duration: 200
        load: sort: 'myorder:desc'
    scope.$on 'resort-mixitup', (event, sortCommand) ->
      angular.element(element).mixItUp 'sort', sortCommand
