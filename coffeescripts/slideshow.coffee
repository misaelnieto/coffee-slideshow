###
Source code for CofeeSlideShow. Generated using cofeescript
Based on cofee-slideshow. Copyright (c) 2011 by Harvest
Last modifications in 2012 by Noe Nieto
###

root = this
$ = jQuery

$.fn.extend({
  coffee_slideshow: (options) ->
    #taken from chose.jquery
    # Do no harm and return as soon as possible for unsupported browsers, namely IE6 and IE7
    return this if $.browser.msie and ($.browser.version is "6.0" or  $.browser.version is "7.0")
    this.each((slideshow) ->
      $this = $ this
      $this.data('cofeee_slideshow', new CoffeeSlideshow(this, options))
    )
})

class CoffeeSlideshow
  timeoutVar: false

  options:
    transitionSpeed: 300,
    delay: 5000,
    slides: '.slides',
    paginators: '.paginators',
    play: '.play',
    next: '.next',
    previous: '.previous',
    activeCSS: 'active',
    AutoPlay: true

  constructor: (@this_slideshow, options={}) ->
    $.extend(@options, options || {})

    slides = @find(@options.slides)
    slides_width = slides.width()
    total_width = slides_width * slides.children().length

    slides.width(total_width.toString() + 'px')

    @find(@options.paginators).children().click(@paginator_click)
    # @find(@options.play).click(@play_click)


  paginator_click: (evt) =>
    clearTimeout(@timeoutVar)

    currentTarget = $(evt.currentTarget)
    currentTarget.addClass(@options.activeCSS)
    siblings = currentTarget.siblings()
    siblings.removeClass(@options.activeCSS)

    slides = @find(@options.slides)
    step = slides.width() / (siblings.length + 1)
    offset = -1 * step * currentTarget.index()
    slides.stop().animate({ marginLeft: offset }, @options.transitionSpeed)

    @find(@options.play).show()

    false

  find: (selector) ->
    $(@this_slideshow).find(selector)


  play_click: ->
    @rotate()
    $(this).hide()
    @play()


  rotate: ->
    current = @find(@options.paginators + ' ' + @options.activeCSS)
    next = current.next()
    first = @find(@options.paginators + ' :first')
    if next.length != 0 then next.trigger('click') else first.trigger('click')


  play: ->
    @rotate()
    @find(@options.play).hide()
    timeoutVar = setTimeout(@play, @options.delay)
