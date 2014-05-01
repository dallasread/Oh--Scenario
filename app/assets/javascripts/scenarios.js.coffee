$(document).on "click", ".error", ->
	$(this).find(".trace").toggle(150)

$ ->
	Scenarios.setOrdinals()

	$('form').on 'click', '.remove_fields', (event) ->
		$(this).closest("td").find('input[type=hidden]').val('1')
		$(this).closest('tr').hide()
		Scenarios.setOrdinals()
		event.preventDefault()

	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$($(this).data('fields').replace(regexp, time)).appendTo(".step_field_wrapper")
		Scenarios.setOrdinals()
		event.preventDefault()

@Scenarios =
	setOrdinals: ->
		$(".step:visible").each ->
			index = $(this).index()
			$(this).find(".step_ordinal").val index