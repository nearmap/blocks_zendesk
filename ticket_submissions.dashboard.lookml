- dashboard: ticket_submissions
  title: Ticket Submissions
  layout: grid
  rows:
    - elements: [all_tickets, orgs_submitting, avg_tickets_per_org]
      height: 150
    - elements: [tickets_submitted_by_org]
      height: 600
    - elements: [peak_hours, peak_days]
      height: 400

  filters:

  - name: date
    type: date_filter
  - name: organization
    type: string_filter


  elements:

  - name: all_tickets
    type: single_value
    model: zendesk
    explore: tickets
    measures: [tickets.count]
    sorts: [tickets.count desc]
    limit: 500
    show_single_value_title: true
    single_value_title: All time tickets submitted
    show_comparison: false
    listen:
      date: tickets.created_date
      organization: tickets.organization_name

  - name: orgs_submitting
    type: single_value
    model: zendesk
    explore: tickets
    measures: [tickets.count_orgs_submitting]
    sorts: [tickets.count_orgs_submitting desc]
    limit: 500
    show_single_value_title: true
    single_value_title: Organizations submitting tickets
    show_comparison: false
    listen:
      date: tickets.created_date
      organization: tickets.organization_name

  - name: avg_tickets_per_org
    title: Average tickets per org
    type: single_value
    model: zendesk
    explore: tickets
    measures: [tickets.count_distinct_organizations, tickets.count]
    dynamic_fields:
    - table_calculation: average_tickets_per_org
      label: Average tickets per org
      expression: round(${tickets.count} / ${tickets.count_distinct_organizations}, 2)
    hidden_fields: [tickets.count_distinct_organizations, tickets.count]
    sorts: [tickets.count_distinct_organizations desc]
    limit: 500
    show_comparison: false
    listen:
      date: tickets.created_date
      organization: tickets.organization_name

  - name: tickets_submitted_by_org
    title: Ticket submitted by organization
    type: looker_line
    model: zendesk
    explore: tickets
    dimensions: [tickets.created_month, tickets.organization_name]
    pivots: [tickets.organization_name]
    measures: [tickets.count]
    sorts: [tickets.count desc, tickets.organization_name]
    limit: 1000
    column_limit: 5000
    stacking: ''
    colors: ['#FFCC00', '#1E2023', '#3399CC', '#CC3399', '#66CC66', '#999999', '#FF4E00', '#A2ECBA', '#9932CC', '#0000CD']
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    listen:
      date: tickets.created_date
      organization: tickets.organization_name


  - name: peak_hours
    title: Peak hours
    type: looker_column
    model: zendesk
    explore: tickets
    dimensions: [tickets.time_hour_of_day]
    measures: [tickets.count]
    sorts: [tickets.time_hour_of_day]
    limit: 500
    column_limit: 50
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    listen:
      date: tickets.created_date
      organization: tickets.organization_name

  - name: peak_days
    title: Peak days
    type: looker_column
    model: zendesk
    explore: tickets
    dimensions: [tickets.created_day_of_week]
    measures: [tickets.count]
    sorts: [tickets.time_day_of_week]
    limit: 500
    column_limit: 50
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    ordering: none
    show_null_labels: false
    listen:
      date: tickets.created_date
      organization: tickets.organization_name
