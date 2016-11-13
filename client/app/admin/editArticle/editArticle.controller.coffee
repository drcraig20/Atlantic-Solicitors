'use strict'

angular.module 'atlanticSolicitorsApp'
.controller 'EditArticleCtrl', ($scope,$timeout,Article,$uibModal,toastr,Solicitor,Utils) ->
  $scope.modalContent = {}
  $scope.checkModel = {};
  $scope.ids = [];
  modal = null
  $timeout ()->
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
        else
          p.find('.panel-body, .panel-footer').slideDown 200
          t.removeClass 'maximize'
          t.find('i').removeClass('fa-plus').addClass 'fa-minus'
        false
  ,1000

  $scope.getArticles = ->
    Article.query (result)->
      $scope.articles = result
  $scope.getArticles()

  $scope.editor = (content,index)->
    if content? and content isnt undefined then $scope.modalContent = content else $scope.modalContent = {}
    if index? and index isnt undefined then $scope.ind = index
    modal = $uibModal.open
      templateUrl: 'app/admin/editArticle/ArticleEdit.html'
      backdrop: 'static'
      scope: $scope
      size: 'lg'

  $scope.editorAdd = ()->
    $scope.modalContent = {}
    modal = $uibModal.open
      templateUrl: 'app/admin/editArticle/ArticleAdd.html'
      backdrop: 'static'
      scope: $scope
      size: 'lg'


  $scope.cancel = ()->
    $scope.submitting = false
    modal.close()

  $scope.save = ()->
    $scope.submitting = true
    if $scope.modalContent.__v then delete $scope.modalContent.__v
    Article.update id:$scope.modalContent._id,$scope.modalContent, (result) ->
      if result._id
        modal.close()
        $scope.submitting = false
        #        $scope.Content[$scope.contactId] = result
        toastr.success 'Data Successfully Saved'
    ,(e) ->
      $scope.submitting = false
      toastr.error 'Opps!!! Something went wrong, and data could not be saved'


# get 200 characters
  $scope.getDescription = (msg)->
    if msg? and msg is undefined
      return ''
    if msg.length > 200
      return msg = msg.substring(0,200)+" ..."
    else
      return msg


  $scope.saveNew = ()->
    $scope.submitting = true
    Article.save $scope.modalContent, (result) ->
      if result._id
        description = Utils.stripTags result.details
        link = {
          article:result._id,
          description: $scope.getDescription(description),
          header : result.header
        }
        Solicitor.updatePushOrPop {mode:'InfoTab',type:'push'}, link, ()->
          modal.close()
          $scope.submitting = false
          $scope.getArticles()
          toastr.success 'Data Successfully Saved'
    ,(e) ->
      $scope.submitting = false
      toastr.error 'Opps!!! Something went wrong, and data could not be saved'

  $scope.pushAndPop = (id)->
    if id not in $scope.ids
      $scope.ids.push id
    else if id in $scope.ids
      _.remove $scope.ids, (a)->
         a == id

  $scope.delete = ->
    if $scope.ids.length
      Article.dispose $scope.ids, (response)->
        if response
          Solicitor.updatePushOrPop {mode:'InfoTab',type:'pop'}, $scope.ids, ()->
            toastr.success response.message
            $scope.getArticles()
      ,(e) ->
        toastr.error 'Data Could Not be deleted.'




