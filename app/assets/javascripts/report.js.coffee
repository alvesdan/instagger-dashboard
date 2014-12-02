class Report
  template: '<table class="table table-bordered">
    <tr>
      <td>Posts</td>
      <td>{{week_1_posts}}</td>
      <td>{{week_2_posts}}</td>
      <td>{{posts_variation}}</td>
    </tr>
    <tr>
      <td>Likes</td>
      <td>{{week_1_likes}}</td>
      <td>{{week_2_likes}}</td>
      <td>{{likes_variation}}</td>
    </tr>
  </table>'

  loadData: ->
    $.ajax
      url: '/dashboard.json'
      async: false
    .responseJSON

  render: ->
    data = @loadData()
    for slice in data
      view =
        week_1_posts: slice.aggregate[1].total_posts
        week_2_posts: slice.aggregate[0].total_posts
        posts_variation: slice.variations.posts

        week_1_likes: slice.aggregate[1].total_likes
        week_2_likes: slice.aggregate[0].total_likes
        likes_variation: slice.variations.likes

      table = Mustache.render(@template, view)
      console.log(table)
      $('.report').append(table)

$ ->
  window.report = new Report()
