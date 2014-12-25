class Report
  template: '
  <div class="week-row clearfix">
    <div class="week-title">
      {{weekOne.week_start}}-{{weekOne.week_end}} vs {{weekTwo.week_start}}-{{weekTwo.week_end}}
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

  render: ->
    data = @loadData()
    for slice in data
      view =
        weekOne: _.first(slice.aggregate)
        weekTwo: _.last(slice.aggregate)
        variations: slice.variations
      table = Mustache.render(@template, view)
      $('.report').append(table)

$ ->
  window.report = new Report()
  report.render()
