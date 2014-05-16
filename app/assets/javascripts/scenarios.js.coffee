$(document).on "click", ".error", ->
	$(this).find(".trace").toggle(150) if $(this).find(".trace").text().length

$(document).on "keyup", ".expects", ->
	Scenarios.hidePasswords()

$(document).on "click", ".remove_fields", (event) ->
	$(this).closest("td").find('input[type=hidden]').val('1')
	$(this).closest('tr').hide()
	Scenarios.setOrdinals()
	event.preventDefault()

$(document).on "click", ".add_fields", (event) ->
	time = new Date().getTime()
	regexp = new RegExp($(this).data('id'), 'g')
	$($(this).data('fields').replace(regexp, time)).appendTo(".step_field_wrapper")
	Scenarios.setOrdinals()
	event.preventDefault()

@Scenarios =
	init: ->
		Scenarios.setOrdinals()
		Scenarios.hidePasswords()
		
		$("#steps").sortable
			axis: "y"
			items: ".step"
			placeholder: "ui-state-highlight"
			forcePlaceholderSize: true
			forceHelperSize: true

			helper: (e, ui) ->
				ui.children().each () ->
					$(this).width $(this).width()
				ui

			start: (e, ui) ->
				ui.placeholder.height ui.item.height()
			
			update: ->
				Scenarios.setOrdinals()

	setOrdinals: ->
		$("#steps").find(".step:visible").each ->
			index = $(this).index()
			$(this).find(".step_ordinal").val index
	
	hidePasswords: ->
		$(".expects").each ->
			if $(this).val()[0] == "*"
				$(this).attr "type", "password"
			else
				$(this).attr "type", "text"