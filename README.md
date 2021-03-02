# Fire-Contain-Prob-Viz
A simple visualization of fire containment probability over time during the start of a fire

During the initial growth of a fire from a point, the fire increases both in size and intensity.  Operational fire behaviour systems such as the Canadian Fire Behaviour Prediction System (https://cfs.nrcan.gc.ca/publications?id=10068) describe this non-linear growth process in a variety of typical circum-boreal and temperature fuels.

The ability of a fire crew with a non-limited surface water supply, power pumps, and helicopter bucket support can be modelled as a simple logistic model (Hirsch et al., 1998, doi: 10.1093/forestscience/44.4.539).  This simple scheme shows how fire suppression probability decreases with increasing fire intensity and size.  

This code snippet provides a simple enhanced visualization for the suppression model of Hirsch over time as a fire grows in size and intensity.  A provision for multiple fuel types is provided.  This visualization also supports the comparison of natural (unmodified) fuels as compared to thinned or otherwise modified fuels with a lower spread rate and intensity.
