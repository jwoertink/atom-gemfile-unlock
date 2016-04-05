module.exports =
class Project

  constructor: (data)->
    @data = data

  load: ()->
    console.log 'Project loaded', @data
