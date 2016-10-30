'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'DashboardCtrl', ($scope) ->
  angular.element('.panel-heading').hover (->
      angular.element(this).find('.panel-btns').fadeIn 'fast'
    ), ->
    angular.element(this).find('.panel-btns').fadeOut 'fast'
# Close Panel
    angular.element('.panel .panel-close').click ->
      angular.element(this).closest('.panel').fadeOut 200
      false
    angular.element('.panel .panel-minimize').click ->
      t = angular.element(this)
      p = t.closest('.panel')
      if !angular.element(this).hasClass('maximize')
        p.find('.panel-body, .panel-footer').slideUp 200
        t.addClass 'maximize'
        t.find('i').removeClass('fa-minus').addClass 'fa-plus'
        angular.element(this).attr('data-original-title', 'Maximize Panel').tooltip()
      else
        p.find('.panel-body, .panel-footer').slideDown 200
        t.removeClass 'maximize'
        t.find('i').removeClass('fa-plus').addClass 'fa-minus'
        angular.element(this).attr('data-original-title', 'Minimize Panel').tooltip()
      false
