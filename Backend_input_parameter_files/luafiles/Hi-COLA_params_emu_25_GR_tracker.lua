------------------------------------------------------------
-- Simulation parameter file
-- This is a LUA script so you can write simple code
-- and use parameter names to set other parameters
-- See ReadParameters.h for which parameters are read
-- and what the standard value is
-- Include other paramfile into this: dofile("param.lua")
------------------------------------------------------------

-- Don't allow any parameters to take optional values?
-- If so we have to provide everything. If not most of the
-- parameters below don't have to be provided and fiduicial values
-- are used instead (see ReadParameters.h for fiducial values)
all_parameters_must_be_in_file = true

------------------------------------------------------------
-- Simulation options
------------------------------------------------------------
-- Label
simulation_name = "my_new_Hi-COLA_simulation_25_GR_tracker"
-- Boxsize of simulation in Mpc/h
simulation_boxsize = 400

------------------------------------------------------------
-- COLA
------------------------------------------------------------
-- Use the COLA method
simulation_use_cola = true
-- If gravity model has scaledependent growth. If this is false
-- then we use the k=0 limit of the growth factors when doing COLA
simulation_use_scaledependent_cola = true

------------------------------------------------------------
-- Choose the cosmology
-- In this example file, the cosmology is from the Planck 2018 release
-- see Table 7 in https://arxiv.org/abs/1807.06205
------------------------------------------------------------
-- Cosmology: LCDM, w0waCDM, DGP, JBD, ... add your own ...
cosmology_model = "LCDM"
--- CDM density
cosmology_OmegaCDM = 0.23382120254658129
--- Baryon density
cosmology_Omegab = 0.05135963252236669
-- Massive neutrino density
cosmology_OmegaMNu = 0.0
-- Total dark energy density
cosmology_OmegaLambda = 0.7147228403983663
-- Effective number of relativistic species
cosmology_Neffective = 3.046
-- Temperature of CMB today
cosmology_TCMB_kelvin = 2.72548
-- Hubble parameter
cosmology_h = 0.6589333333333334
-- Primodial amplitude
cosmology_As = 1.866e-09
-- Spectral index
cosmology_ns = 0.9112
-- Pivot scale in 1/Mpc
cosmology_kpivot_mpc = 0.05

-- HiCOLA model, read background from file
if cosmology_model == "HiCOLA" then
  -- Name of file that contains [k, E, dlogH/dloga]
  HiCOLA_expansion_filename = "/global/homes/c/carolazn/Output/horndeski_model_run 8_expansion.txt"
end

-- The w0wa parametrization
if cosmology_model == "w0waCDM" then
  cosmology_w0 = -1.0
  cosmology_wa = 0.0
end

-- DGP self-accelerating model
if cosmology_model == "DGP" then
  cosmology_dgp_OmegaRC = 0.11642
end

-- Jordan-Brans-Dicke
if cosmology_model == "JBD" then
  -- The JBD parameter
  cosmology_JBD_wBD = 1000.0
  -- The IC is set as to produce G_N / phi(a=1) = GeffG_today
  cosmology_JBD_GeffG_today = 1.0
  -- We require physical parameters. h is a derived quantity
  cosmology_JBD_Omegabh2 = 0.025
  cosmology_JBD_OmegaMNuh2 = 0.0
  cosmology_JBD_OmegaCDMh2 = 0.12
  cosmology_JBD_OmegaLambdah2 = 0.3
  cosmology_JBD_OmegaKh2 = 0.0
end

------------------------------------------------------------
-- Choose the gravity model
------------------------------------------------------------
-- Gravity model: GR, DGP, f(R), JBD, Symmetron, ... add your own ...
gravity_model = "GR"

-- HiCOLA model
if gravity_model == "HiCOLA" then
  -- Name of file that contains [k, chi/delta, coupling]
  HiCOLA_preforce_filename = "/global/homes/c/carolazn/Output/horndeski_model_run 8_force.txt"
  -- Approximate screening model (otherwise linear)
  gravity_model_screening = true
  -- For screening approx: smoothing filter for density (tophat, gaussian, sharpk)
  gravity_model_HiCOLA_smoothing_filter = "gaussian"
  -- For screening approx: smoothing scale R/boxsize
  gravity_model_HiCOLA_smoothing_scale_over_boxsize = 3.0 / simulation_boxsize
  -- Combine screeneed solution with linear solution to enforce correct
  -- linear evolution on large scales
  gravity_model_screening_enforce_largescale_linear = true
  -- The fourier scale for which we use the linear solution for k < k*
  -- and the screened solution for k > k*
  gravity_model_screening_linear_scale_hmpc = 0.2
end

-- Hu-Sawicky f(R) model
if gravity_model == "f(R)" then
  -- f_R0 value
  gravity_model_fofr_fofr0 = 1e-5
  -- The index n
  gravity_model_fofr_nfofr = 1.0
  -- Solve exact f(R) equation using the multigridsolver (slow and mainly for testing)
  -- This option takes precedent over the approximate screening model below if both are set
  gravity_model_fofr_exact_solution = false
  -- Approximate screening model (otherwise linear)
  gravity_model_screening = true
  -- Combine screeneed solution with linear solution to enforce correct
  -- linear evolution on large scales
  gravity_model_screening_enforce_largescale_linear = false
  -- The fourier scale for which we use the linear solution for k < k*
  -- and the screened solution for k > k*
  gravity_model_screening_linear_scale_hmpc = 0.1


  -- Options for the multigrid solver in case we solve exact equation:
  multigrid_solver_residual_convergence = 1e-7
  -- How many Newton-Gauss-Seidel sweeps to do every level
  multigrid_nsweeps = 5
  -- In some cases the multigrid solver fails if we are not close to the
  -- solution before starting multigrid. Increase this if so
  multigrid_nsweeps_first_step = 5
end

-- Symmetron model
if gravity_model == "Symmetron" then
  -- Symmetry breaking scalefactor (no fifth-force for a < assb)
  gravity_model_symmetron_assb = 0.333
  -- Coupling strength relative to gravity
  gravity_model_symmetron_beta = 1.0
  -- Range of force in background today
  gravity_model_symmetron_L_mpch = 1.0
  -- Solve exact symmetron equation using the multigridsolver (slow and mainly for testing)
  -- This option takes precedent over the approximate screening model below if both are set
  gravity_model_symmetron_exact_solution = false
  -- Approximate screening model (otherwise linear)
  gravity_model_screening = false
  -- Combine screeneed solution with linear solution to enforce correct
  -- linear evolution on large scales
  gravity_model_screening_enforce_largescale_linear = false
  -- The fourier scale for which we use the linear solution for k < k*
  -- and the screened solution for k > k*
  gravity_model_screening_linear_scale_hmpc = 0.1

  -- Options for the multigrid solver in case we solve exact equation:
  multigrid_solver_residual_convergence = 1e-7
  -- How many Newton-Gauss-Seidel sweeps to do every level
  multigrid_nsweeps = 5
  -- In some cases the multigrid solver fails if we are not close to the
  -- solution before starting multigrid. Increase this if so
  multigrid_nsweeps_first_step = 5
end

-- DGP model (pick LCDM as the cosmology to get the normal branch)
-- For the self accelerating branch rcH0 must have a negative sign
if gravity_model == "DGP" then
  -- The cross-over scale rc*H0/c
  gravity_model_dgp_rcH0overc = 1.0
  -- Solve exact DGP equation using the multigridsolver (slow and mainly for testing)
  -- This option takes precedent over the approximate screening model below if both are set
  -- NB: this is not always easy to get to work, its a tricky equation, and might saturate at
  -- a given residual level (and then you will have to reduce the epsilon and deem that to be converged)
  gravity_model_dgp_exact_solution = false
  -- Approximate screening model (otherwise linear)
  gravity_model_screening = true
  -- For screening approx: smoothing filter for density (tophat, gaussian, sharpk)
  gravity_model_dgp_smoothing_filter = "tophat"
  -- For screening approx: smoothing scale R/boxsize
  gravity_model_dgp_smoothing_scale_over_boxsize = 0.0 / simulation_boxsize
  -- Combine screeneed solution with linear solution to enforce correct
  -- linear evolution on large scales
  gravity_model_screening_enforce_largescale_linear = true
  -- The fourier scale for which we use the linear solution for k < k*
  -- and the screened solution for k > k*
  gravity_model_screening_linear_scale_hmpc = 0.1

  -- Options for the multigrid solver in case we solve exact equation:
  multigrid_solver_residual_convergence = 1e-4
  -- How many Newton-Gauss-Seidel sweeps to do every level
  multigrid_nsweeps = 2
  -- In some cases the multigrid solver fails if we are not close to the
  -- solution before starting multigrid. Increase this if so
  multigrid_nsweeps_first_step = 2
end

------------------------------------------------------------
-- Particles
------------------------------------------------------------
-- Number of CDM+b particles per dimension
particle_Npart_1D = 512
-- Factor of how many more particles to allocate space
particle_allocation_factor = 2.0

------------------------------------------------------------
-- Output
------------------------------------------------------------
-- List of output redshifts
output_redshifts = {0.0}
-- Output particles?
output_particles = false
-- Fileformat: GADGET, FML
output_fileformat = "GADGET"
-- Output folder
output_folder = "/home/c2042999/HiCOLA_env/Cubic_galileon_emu-ICGweek/Output_backend/COLA_25_GR_tracker"

------------------------------------------------------------
-- Time-stepping
------------------------------------------------------------
-- Number of steps between the outputs (in output_redshifts).
-- If only one number in the list then its the total number of steps
timestep_nsteps = {50}
-- The time-stepping method: Quinn, Tassev
timestep_method = "Quinn"
-- For Tassev: the nLPT parameter
timestep_cola_nLPT = -2.5
-- The time-stepping algorithm: KDK
timestep_algorithm = "KDK"

-- Spacing of the time-steps in 'a' is: linear, logarithmic, powerlaw
timestep_scalefactor_spacing = "linear"
if timestep_scalefactor_spacing == "powerlaw" then
  timestep_spacing_power = 1.0
end

------------------------------------------------------------
-- Initial conditions
------------------------------------------------------------
-- The random seed
ic_random_seed =108
-- The random generator (GSL or MT19937). Fiducial GSL is gsl_rng_ranlxd1 (as used in the 2LPTIC code for comparison)
ic_random_generator = "GSL"
-- Fix amplitude when generating the gaussian random field
ic_fix_amplitude = true
-- Mirror the phases (for amplitude-fixed simulations)
ic_reverse_phases = false
-- Type of IC: gaussian, nongaussian, read_particles
ic_random_field_type = "gaussian"
-- The grid-size used to generate the IC
ic_nmesh = particle_Npart_1D
-- For MG: input LCDM P(k) and use GR to scale back and ensure same IC as for LCDM
ic_use_gravity_model_GR = true
-- The LPT order to use for the IC
ic_LPT_order = 2
-- The type of input:
-- powerspectrum    (file with [k (h/Mph) , P(k) (Mpc/h)^3)])
-- transferfunction (file with [k (h/Mph) , T(k)  Mpc^2)]
-- transferinfofile (file containing paths to a bunch of T(k,z) files from CAMB)
-- read_particles   (read GADGET file and use that for sim - reconstruct LPT fields if COLA)
ic_type_of_input = "powerspectrum"
-- Path to the input (NB: the LCDM spectrum below is an example that comes with Hi-COLA)
ic_input_filename = "/home/c2042999/HiCOLA_env/Cubic_galileon_emu-ICGweek/Backend_input_parameter_files/P_k_z/Pk_lin_z49_LCDM_backscaled_25.dat"
-- The redshift of the P(k), T(k) we give as input
ic_input_redshift = 49.0
-- The initial redshift of the simulation
ic_initial_redshift = 49.0
-- Normalize wrt sigma8? Otherwise use normalization in input + As etc.
-- If ic_use_gravity_model_GR then this is the sigma8 value is a corresponding GR universe!
ic_sigma8_normalization = false
-- Redshift of sigma8 value to normalize wrt
ic_sigma8_redshift = 0.0
-- The sigma8 value to normalize wrt
ic_sigma8 = 0.83

if ic_random_field_type == "nongaussian" then
  -- Type of non-gaussian IC: local, equilateral, orthogonal
  ic_fnl_type = "local"
  -- The fNL value
  ic_fnl = 100.0
  -- The redshift of which to apply the non-gaussian potential
  ic_fnl_redshift = ic_initial_redshift
end

-- For reading IC from an external file
-- If COLA then we reconstruct the LPT fields
if ic_random_field_type == "read_particles" then
  -- Path to GADGET files
  ic_reconstruct_gadgetfilepath = "<existing_simulation_snapshot>/gadget"
  -- COLA settings to (naively) reconstruct the LPT fields:
  -- Density assignment method: NGP, CIC, TSC, PCS, PQS
  -- We use ic_nmesh to set the grid to compute the density field on
  -- NB: this should be equal to the nmesh used to generate the IC (i.e. NpartTot^1/3)
  ic_reconstruct_assigment_method = "PQS"
  ic_reconstruct_interlacing = false
  -- Smoothing filter to remove small-scale modes (only relevant if for
  -- some reason you want ic_nmesh to be larger than the grid it was created on)
  ic_reconstruct_smoothing_filter = "sharpk"
  ic_reconstruct_dimless_smoothing_scale = 1.0 /(2.0 * math.pi * ic_nmesh / 2)
end

------------------------------------------------------------
-- Force calculation
------------------------------------------------------------
-- Grid to use for computing PM forces
force_nmesh = 1536
-- Density assignment method: NGP, CIC, TSC, PCS, PQS
force_density_assignment_method = "CIC"
-- The kernel to use when solving the Poisson equation
force_kernel = "continuous_greens_function"
-- Include the effects of massive neutrinos when computing
-- the density field (density of mnu is the linear prediction)
-- Requires: transferinfofile above (we need all T(k,z))
force_linear_massive_neutrinos = true

------------------------------------------------------------
-- On the fly analysis
------------------------------------------------------------

------------------------------------------------------------
-- Halofinding
------------------------------------------------------------
-- Do halofinding every output?
fof = false
-- Minimum number of particles per halo
fof_nmin_per_halo = 20
-- The fof distance (rmin / boxsize) used when linking
fof_linking_length = 0.2 / particle_Npart_1D
-- Limit the maximum grid to use to bin particles to
-- to speed up the fof linking. 0 means we let the code choose this
fof_nmesh_max = 0

------------------------------------------------------------
-- Power-spectrum evaluation
------------------------------------------------------------
-- Compute power-spectrum when we output
pofk = true
-- Gridsize to use for this
pofk_nmesh = 1536
-- Use interlaced grids for alias reduction?
pofk_interlacing = true
-- Subtract shotnoise?
pofk_subtract_shotnoise = true
-- Density assignment method: NGP, CIC, TSC, PCS, PQS, ...
pofk_density_assignment_method = "PCS"

------------------------------------------------------------
-- Power-spectrum multipole evaluation
------------------------------------------------------------
-- Compute redshift space multipoles P_ell(k) when outputting
pofk_multipole = false
-- Gridsize to use for this
pofk_multipole_nmesh = 128
-- Use interlaced grids for alias reduction?
pofk_multipole_interlacing = true
-- Subtract shotnoise for P0?
pofk_multipole_subtract_shotnoise = false
-- Maximum ell we want P_ell for
pofk_multipole_ellmax = 4
-- Density assignment method: NGP, CIC, TSC, PCS, PQS
pofk_multipole_density_assignment_method = "PCS"

------------------------------------------------------------
-- Bispectrum evaluation
------------------------------------------------------------
-- Compute the bispectrum when we output?
bispectrum = false
-- Gridsize to use for this
bispectrum_nmesh = 128
-- Number of bins in k. NB: we need to store nbins grids and
-- do nbins^3 integrals so both memory and computationally expensive
bispectrum_nbins = 10
-- Use interlaced grids for alias reduction?
bispectrum_interlacing = true
-- Subtract shotnoise?
bispectrum_subtract_shotnoise = false
-- Density assignment method: NGP, CIC, TSC, PCS, PQS
bispectrum_density_assignment_method = "PCS"
