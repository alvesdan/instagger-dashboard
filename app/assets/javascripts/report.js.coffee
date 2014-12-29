class Report
  template: '
  <div class="week-row clearfix">
    <div class="week-title">
      {{weekOne.week_start}}-{{weekOne.week_end}} <span class="versus">and</span> {{weekTwo.week_start}}-{{weekTwo.week_end}}
    </div>
    <div class="week-resume">
      <div class="posts">
        <small>Posts:</small>
        {{weekOne.total_posts}}
      </div>
      <div class="likes">
        <small>Likes:</small>
        {{weekOne.total_likes}}
      </div>
      <div class="comments">
        <small>Comments:</small>
        {{weekOne.total_comments}}
      </div>
    </div>
    <div class="week-comparison">
      <div class="posts">
        {{variations.posts}}%
      </div>
      <div class="likes">
        {{variations.likes}}%
      </div>
      <div class="comments">
        {{variations.comments}}%
      </div>
    </div>
    <div class="week-resume">
      <div class="posts">
        <small>Posts:</small>
        {{weekTwo.total_posts}}
      </div>
      <div class="likes">
        <small>Likes:</small>
        {{weekTwo.total_likes}}
      </div>
      <div class="comments">
        <small>Comments:</small>
        {{weekTwo.total_comments}}
      </div>
    </div>
  </div>
  '

  loadData: ->
    $.ajax
      url: '/dashboard.json'
      async: false
    .responseJSON

  emptyReport: ->
    $('.report').html('<p>No data to display for the last 4 weeks.</p>')

  render: ->
    data = @loadData()
    return @emptyReport() unless data.length
    for slice in data
      view =
        weekOne: _.first(slice.aggregate)
        weekTwo: _.last(slice.aggregate)
        variations: slice.variations
      table = Mustache.render(@template, view)
      $('.report').append(table)
      @parseVariations()
    null # return nothing

  parseVariations: ->
    $('.week-comparison').find('.posts, .likes, .comments').each ->
      $this = $(this)
      raw = $this.html().trim()
      parsed = parseInt(raw.replace('%', ''))
      klass = if parsed > 0 then 'up' else 'down'
      klass = 'flat' if parsed == 0
      $this.addClass(klass)

$ ->
  window.report = new Report()
  report.render()
