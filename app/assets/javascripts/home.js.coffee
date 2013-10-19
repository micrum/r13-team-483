
@.App = {

  initSampleGroupsPreview: ->
    that = @
    $('.samples').each(->
      $sampleGroup = $(@)
      maxTime = $sampleGroup.data('max-time')
      that.initSampleGroupPreview($sampleGroup, maxTime)
    )
    return


  initSampleGroupPreview: ($sampleGroup, maxTime) ->
    if (!maxTime)
      return
    that = @
    samples = $sampleGroup.find('.sample')
    samples.each( ->
      that.initSamplePreview($(@), maxTime);
    )

    return


  initSamplePreview: ($sample, maxTime) ->
    $bar = $sample.find('.bar')
    time = $bar.data('time')
    percent = time / maxTime * 100
    $bar.css({width: percent + '%'})

    return

  drow_plots: (id)->
    horizontal = true
    $.ajax
      url: 'benchmark' + id + '/result.json',
      method: 'get',
      success: ->
        alert(1)

}
