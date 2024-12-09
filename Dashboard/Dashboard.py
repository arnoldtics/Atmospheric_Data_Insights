import pandas as pd
import dash
from dash import dcc, html
import dash_bootstrap_components as dbc
from dash.dependencies import Input, Output
import plotly.express as px

df = pd.read_csv("Preprocess.csv")

airQuality = ["O3", "NO2", "NO", "CO", "PM10", "PM2.5"]
colorsQuality = ["cyan", "darkgreen", "springgreen", "purple", "red", "peru"]
unitsQuality = ["ppb", "ppb", "ppb", "ppb", "ug/m^3", "ug/m^3"]

meteorology = ["Temp_Avg", "RH_Avg", "WSpeed_Avg", "WDir_Avg", "Rain_Tot", "Press_Avg", "Rad_Avg"]
colorsMeteorology = ["firebrick", "olivedrab", "blueviolet", "deeppink", "deepskyblue", "blue", "darkgoldenrod"]
unitsMeteorology = ["°C", "%", "m/s", "degrees", "mm", "hPa", "W/m^2"]

# App Dash
tablero = dash.Dash(__name__, external_stylesheets=[dbc.themes.BOOTSTRAP])

# Layout 
tablero.layout = dbc.Container([
    html.H1("Atmospheric Data Dashboard", className="text-center mb-4"),

    # Air Quality Section
    html.H2("Air Quality"),
    dcc.Dropdown(
        id="dropdown-air",
        options=[{"label": var, "value": var} for var in airQuality],
        value=airQuality,  # Start with all of the variables
        multi=True,
        placeholder="Select an air quality variable",
    ),
    dcc.Graph(id="boxplot-air"),
    dcc.Graph(id="density-air"),

    html.Hr(),

    # Meteorology Section
    html.H2("Meteorology"),
    dcc.Dropdown(
        id="dropdown-meteorology",
        options=[{"label": var, "value": var} for var in meteorology],
        value=meteorology,  # Start with all of the variables
        multi=True,
        placeholder="Select a meteorology variable",
    ),
    dcc.Graph(id="boxplot-meteorology"),
    dcc.Graph(id="density-meteorology"),
], fluid=True)

# Function to melt data (long format transformation)
def melt_data(df, selected_vars, var_type, units):
    melted_df = pd.melt(
        df,
        value_vars=selected_vars,
        var_name="Variable",
        value_name="Value"
    )
    melted_df["Unidad"] = melted_df["Variable"].map(
        lambda x: units[airQuality.index(x)] if var_type == "air" else units[meteorology.index(x)]
    )
    return melted_df

# Callback to update graphics of air quality
@tablero.callback(
    [Output("boxplot-air", "figure"),
     Output("density-air", "figure")],
    [Input("dropdown-air", "value")]
)
def update_air_quality_plots(selected_vars):
    if not selected_vars:
        return px.box(), px.scatter()  # Empty plot if none selected

    # Boxplot
    data_box = melt_data(df, selected_vars, "air", unitsQuality)
    fig_box = px.box(
        data_frame=data_box,
        x="Variable",
        y="Value",
        color="Variable",
        color_discrete_sequence=colorsQuality[:len(selected_vars)],
        points="all"
    )
    fig_box.update_layout(
        title="Air Quality Boxplots",
        yaxis_title="Value (depends on air quality units)",
        showlegend=False
    )

    # Density plot
    fig_density = px.density_contour(
        data_frame=data_box,
        x="Variable",
        y="Value",
        color="Variable",
        marginal_x="box",
        marginal_y="violin",
        color_discrete_sequence=colorsQuality[:len(selected_vars)]
    )
    fig_density.update_layout(
        title="Air Quality Density Distribution",
        showlegend=False
    )
    return fig_box, fig_density

# Callback to update graphics of meteorology
@tablero.callback(
    [Output("boxplot-meteorology", "figure"),
     Output("density-meteorology", "figure")],
    [Input("dropdown-meteorology", "value")]
)
def update_meteorology_plots(selected_vars):
    if not selected_vars:
        return px.box(), px.scatter()  # Empty plots if none selected

    # Boxplot
    data_box = melt_data(df, selected_vars, "meteorology", unitsMeteorology)
    fig_box = px.box(
        data_frame=data_box,
        x="Variable",
        y="Value",
        color="Variable",
        color_discrete_sequence=colorsMeteorology[:len(selected_vars)],
        points="all"
    )
    fig_box.update_layout(
        title="Meteorology Boxplots",
        yaxis_title="Value (depends on air quality units)",
        showlegend=False
    )

    # Density plot
    fig_density = px.density_contour(
        data_frame=data_box,
        x="Variable",
        y="Value",
        color="Variable",
        marginal_x="box",
        marginal_y="violin",
        color_discrete_sequence=colorsMeteorology[:len(selected_vars)]
    )
    fig_density.update_layout(
        title="Meteorology Density Distribution",
        showlegend=False
    )
    return fig_box, fig_density

# Run server
if __name__ == "__main__":
    tablero.run_server(debug=True, port=8000, host="127.0.0.1")
