- dashboard: representative_performance
  title: "Sales Representative Performance Dashboard"
  layout: tile
  tile_size: 100
  
# @shaun: i'd recommend using a grid layout (https://looker.com/docs/reference/dashboard-reference)
# where you can specify the height of each row and the elements in each row. the dashboards look very funky
# right now. here's an example:

#   layout: grid
#   rows:
#     - elements: [count_won_deals, salesrep_total_revenue, ...]
#       height: 150
#     - elements: [something_else]
#       height: 300

  filters:
  
  - name: sales_rep
    type: field_filter
    explore: opportunity
    field: opportunity_owner.name
    
  - name: sales_segment
    type: field_filter
    explore: account
    field: account.business_segment
    default_value: 'Enterprise'

  elements:

  - name: count_won_deals
    title: 'Count of Won Deals (This Quarter)'
    type: single_value
    model: salesforce
    explore: opportunity
    measures: [opportunity.count_won]
    listen:
      sales_segment: account.business_segment
      sales_rep: opportunity_owner.name
    filters:
      opportunity.close_date: last quarter
    limit: 500
    font_size: small
    text_color: '#49719a'
    width: 3
    height: 2

  - name: salesrep_total_revenue
    title: 'Salesrep - Total Revenue (This Quarter)'
    type: single_value
    model: salesforce
    explore: opportunity
    measures: [opportunity.total_revenue]
    listen:
      sales_segment: account.business_segment
      sales_rep: opportunity_owner.name
    filters:
      opportunity.close_date: 'last quarter'
    limit: 500
    font_size: small
    text_color: '#49719a'
    width: 3
    height: 2 
    
  - name: count_lost_deals
    title: 'Count of Lost Deals (This Quarter)'
    type: single_value
    model: salesforce
    explore: opportunity
    measures: [opportunity.count_lost]
    listen:
      sales_segment: account.business_segment
      sales_rep: opportunity_owner.name
    filters:
      opportunity.close_date: 'last quarter'
    limit: 500
    font_size: small
    text_color: '#49719a'
    width: 3
    height: 2
    
  - name: win_percentage
    title: 'Win Percentage of Closed Deals (This Quarter)'
    type: single_value
    model: salesforce
    explore: opportunity
    measures: [opportunity.win_percentage]
    listen:
      sales_segment: account.business_segment
      sales_rep: opportunity_owner.name
    filters:
      opportunity.close_date: 'last quarter'
    limit: 500
    font_size: small
    text_color: '#49719a'
    width: 3
    height: 2
    
  - name: opportunities_to_wins_trend_peers
    title: 'Opportunities to Wins by Rep'
    type: looker_line
    model: salesforce
    explore: opportunity
    dimensions: [opportunity.created_month, opportunity_owner.rep_comparitor]
    pivots: [opportunity_owner.rep_comparitor]
    measures: [opportunity.count, opportunity.count_won]
    dynamic_fields:
    - table_calculation: opportunities_to_won
      label: opportunities_to_won
      expression: 1.0*${opportunity.count_won}/${opportunity.count}
      value_format: '#.0%'
    hidden_fields: [opportunity.count_won, opportunity.count]
    listen:
      sales_segment: opportunity_owner.department_select
      sales_rep: opportunity_owner.name_select 
    filters:
      opportunity.created_month: 9 months ago for 9 months
    sorts: [opportunity.created_month desc, opportunity_owner.rep_comparitor]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ['#FFCC00', '#1E2023', '#3399CC', '#CC3399', '#66CC66', '#999999', '#FF4E00', '#A2ECBA', '#9932CC', '#0000CD']
    show_value_labels: false
    label_density: 25
    font_size: small
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_value_format: '#%'
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_points: true
    point_style: none
    interpolation: linear
    width: 12
    height: 4
    
  - name: salesrep_revenue_won_comparison
    title: 'SalesRep - Revenue Won comparison'
    type: looker_bar
    model: salesforce
    explore: opportunity
    dimensions: [opportunity_owner.rep_comparitor]
    measures: [opportunity.average_revenue_won]
    listen:
      sales_segment: opportunity_owner.department_select
      sales_rep: opportunity_owner.name_select 
    sorts: [opportunity_owner.rep_comparitor]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ['#FFCC00', '#1E2023', '#3399CC', '#CC3399', '#66CC66', '#999999', '#FF4E00', '#A2ECBA', '#9932CC', '#0000CD']
    show_value_labels: true
    label_density: 25
    label_color: ['#3399CC']
    font_size: small
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Total Revenue Won]
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    width: 6
    height: 3
    
  - name: salesrep_win_rate_comparison
    title: 'SalesRep - Win Rate Comparison'
    type: looker_bar
    model: salesforce
    explore: opportunity
    dimensions: [opportunity_owner.rep_comparitor]
    measures: [opportunity.win_percentage]
    listen:
      sales_segment: opportunity_owner.department_select
      sales_rep: opportunity_owner.name_select 
    sorts: [opportunity_owner.rep_comparitor]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ['#FFCC00', '#1E2023', '#3399CC', '#CC3399', '#66CC66', '#999999', '#FF4E00', '#A2ECBA', '#9932CC', '#0000CD']
    show_value_labels: true
    label_density: 25
    label_color: ['#3399CC']
    font_size: small
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Opportunity Win Rate]
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    width: 6
    height: 3
    
  - name: salesrep_revenue_pipeline_comparison
    title: 'SalesRep - Revenue Pipeline comparison'
    type: looker_bar
    model: salesforce
    explore: opportunity
    dimensions: [opportunity_owner.rep_comparitor]
    measures: [opportunity_owner.average_revenue_pipeline]
    listen:
      sales_segment: opportunity_owner.department_select
      sales_rep: opportunity_owner.name_select 
    sorts: [opportunity_owner.rep_comparitor]
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    colors: ['#FFCC00', '#1E2023', '#3399CC', '#CC3399', '#66CC66', '#999999', '#FF4E00', '#A2ECBA', '#9932CC', '#0000CD']
    show_value_labels: true
    label_density: 25
    label_color: ['#3399CC']
    font_size: small
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_labels: [Total Revenue Pipeline]
    y_axis_tick_density: default
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
    width: 6
    height: 3    
