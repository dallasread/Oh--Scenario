@unload = ->
	$(".loading").show()

load = ->
	$(".loading").hide()
	Scenarios.init()

$ ->
	load()

document.addEventListener "page:fetch", unload
document.addEventListener "page:change", load