
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
      url: id + '/results.json',
      method: 'get',
      success: (data)->
        alert data[0].all_systime.each ->
          alert this


  finishPing: false,
  sampleGroup: null,

  statusInfo: {
    'running': {icon: 'icon-cogs', title: 'The sample is being executed'},
    'completed': {icon: 'icon-smile', title: 'The sample is measured'},
    'error': { icon: 'icon-exclamation-sign', title: 'An error occured during sample executuion'},
    'timeout': {icon: 'icon-ban-circle', title: 'The sample exceeded time limit'},
    'pending': {icon: 'icon-time', title: 'The sample is in queue'}
  }

  updateSampleStatus: ($elem, statusText) ->
    $h3 = $elem.find('h3')
    sinfo = @.statusInfo[statusText]
    sinfo ||= {icon: 'icon-question', title: 'Unknown status'}
    $h3.find('.state-icon i').attr('class', sinfo['icon'])
    $h3.attr('title', sinfo['title'])


  updateSampleData: ($elem, sampleData) ->
    $elem.find('.val-sys-time').html(sampleData['sys_time_text'])
    $elem.find('.val-user-time').html(sampleData['user_time_text'])
    $elem.find('.val-real-time').html(sampleData['real_time_text'])
    $elem.find('.val-memory').html(sampleData['memory_text'])

    @.updateSampleStatus($elem, sampleData['status_text'])


  updateSamplesData: (samples) ->
    that = @
    hasPendingOrRunning = false

    $.each samples, (index, sampleData) ->
      $elem = $('.sample-info[data-sample-id="' + sampleData['id'] + '"]')
      that.updateSampleData($elem, sampleData)

      if ((sampleData['status_text'] == 'pending') || (sampleData['status_text'] == 'running'))
        hasPendingOrRunning = true

      if !hasPendingOrRunning
        @.finishPing = true

  pingSamples: ->
    app = @

    $.ajax({
      url: @.sampleGroupURL,
      dataType: 'json',
      success: (data) ->
        app.updateSamplesData(data.samples)
    })

    if (!@.finishPing)
      setTimeout((-> app.pingSamples()), 5000)


  initSamplePing: ->
    @.sampleGroupURL = window.location
    @.pingSamples()

}
