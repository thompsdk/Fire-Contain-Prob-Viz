# Fire-Contain-Prob-Viz
A simple visualization of fire containment probability over time during the start of a fire

During the initial growth of a fire from a point, the fire increases both in size and intensity.  Operational fire behaviour systems such as the Canadian Fire Behaviour Prediction System (https://cfs.nrcan.gc.ca/publications?id=10068) describe this non-linear growth process in a variety of typical circum-boreal and temperature fuels.

The ability of a fire crew with a non-limited surface water supply, power pumps, and helicopter bucket support can be modelled as a simple logistic model (Hirsch et al., 1998, https://academic.oup.com/forestscience/article/44/4/539/4627517).  This simple scheme shows how fire suppression probability decreases with increasing fire intensity and size.  

This code snippet provides a simple enhanced visualization for the suppression model of Hirsch over time as a fire grows in size and intensity.  Isolines of equal containment probabilty are mapped, and the time series of the fire's growth is shown.  A provision for multiple fuel types is provided.  This visualization also supports the comparison of natural (unmodified) fuels as compared to thinned or otherwise modified fuels with a lower spread rate and intensity.

This code repository supports the fuels management decision-making process as it relates to initial suppression likelihood, which is a highly non-linear effect over time. 

Examples of the application of this are shown in the attached pdf, which is fire behaviour modelling in boreal black spruce stands using the FIRETEC model (https://www.mdpi.com/2571-6255/3/2/18)

Note that the suppression likelihood model from Hirsch used here is only one example of suppression likelihood, and is only applicable for boreal conifer stands.  Other suppression models for additional fuel types can be substituted by the user.
