##= require ./option_view

class SurveyBuilderV2.Views.LeftPane.MultiChoiceOptionView extends SurveyBuilderV2.Views.LeftPane.OptionView
  events:
    "click": "makeActive"
    "click .option-delete-button": "destroyOption"
    "click .question-add-sub-question": "addSubQuestion"

  initialize: (attributes) =>
    @model = attributes.model
    @template = SMT["v2_survey_builder/surveys/left_pane/multi_choice_option"]

    super(attributes)
    @id=attributes.survey_id

  addSubQuestion: (event)=>
    event.stopPropagation()
    view = @addQuestion({ survey_id: @id, parent_id: @model.id})
    @getLeftPane().append(view.render().el)
    view.makeActive()

  addQuestion: (attributes) =>
    el = this.$el.find(".question[data-id=#{attributes.id}]") if attributes.id
    type = el.data("type") if attributes.type
    view = SurveyBuilderV2.Views.QuestionCreator.render(type, el, attributes)
    view

  getLeftPane: => this.$el.find(".survey-panes-left-pane")
