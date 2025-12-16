library(math3150package)
library(readxl)
library(GGally)
library(car)
library(DataExplorer)
temp = read_excel("PCOS_data_without_infertility.xlsx")

###################

DataExplorer::plot_histogram(
  geom_histogram_args = list(alpha = 0.5, fill = "salmon",bins=20),
  data = temp)

# data preparation
####################

data = temp|>
  mutate(pcos = `PCOS (Y/N)`,
         age = `Age (yrs)`,
         weight = `Weight (Kg)`,
         height = `Height(Cm)`,
         bmi = BMI,
         blood_group = `Blood Group`,
         pulse_rate = `Pulse rate(bpm)`,
         rr = `RR (breaths/min)`,
         hb = `Hb(g/dl)`,
         cycle = `Cycle(R/I)`,
         cycle_length = `Cycle length(days)`,
         marital_status = `Marraige Status (Yrs)`,
         pregnant = `Pregnant(Y/N)`,
         no_of_abortions = `No. of aborptions`,
         i_beta_hcg = `I   beta-HCG(mIU/mL)`,
         ii_beta_hcg = `II    beta-HCG(mIU/mL)`,
         fsh = `FSH(mIU/mL)`,
         lh = `LH(mIU/mL)`,
         fsh_lh = `FSH/LH`,
         hip = `Hip(inch)`*2.54,
         waist = `Waist(inch)`*2.54,
         waist_hip_ratio = `Waist:Hip Ratio`*2.54,
         tsh = `TSH (mIU/L)`,
         amh = `AMH(ng/mL)`,
         prl = `PRL(ng/mL)`,
         d3 = `Vit D3 (ng/mL)`,
         prg = `PRG(ng/mL)`,
         rbs = `RBS(mg/dl)`,
         weight_gain = `Weight gain(Y/N)`,
         hair_growth = `hair growth(Y/N)`,
         skin_darkening = `Skin darkening (Y/N)`,
         hair_loss = `Hair loss(Y/N)`,
         pimples = `Pimples(Y/N)`,
         fast_food = `Fast food (Y/N)`,
         exercise = `Reg.Exercise(Y/N)`,
         bp_systolic = `BP _Systolic (mmHg)`,
         bp_diastolic = `BP _Diastolic (mmHg)`,
         follicle_l = `Follicle No. (L)`,
         follicle_r = `Follicle No. (R)`,
         avg_fol_sz_l = `Avg. F size (L) (mm)`,
         avg_fol_sz_r = `Avg. F size (R) (mm)`,
         endometrium = `Endometrium (mm)`)|>
  select(46:87)

dim(data)

colSums(is.na(data))
data = na.omit(data)

DataExplorer::plot_histogram(
  geom_histogram_args = list(alpha = 0.5, fill = "cornflowerblue",bins=20),
  data = data)

#model creation
###############

full_mod = glm(pcos~age+weight+height+bmi+blood_group+pulse_rate+rr+hb+cycle+
                 cycle_length+marital_status+pregnant+no_of_abortions+i_beta_hcg
               +ii_beta_hcg+fsh+lh+fsh_lh+hip+waist+waist_hip_ratio+tsh+amh+prl+
                 d3+prg+rbs+weight_gain+hair_growth+skin_darkening+hair_loss+
                 pimples+fast_food+exercise+bp_systolic+bp_diastolic+follicle_l+
                 follicle_r+avg_fol_sz_l+avg_fol_sz_r+endometrium,data,
               family=binomial)
summary(full_mod)

# model selection
step(full_mod)

mod = glm(pcos~pulse_rate+cycle+marital_status+lh+prg+weight_gain+hair_growth+
            skin_darkening + pimples + fast_food+exercise+follicle_l+follicle_r
            ,data=data,family=binomial)
summary(mod)

# diagnostics
#############

# How well does it predict?

ptest = as.numeric(mod$fitted>0.5)
table(truth=data$pcos, prediction = ptest)

(344+153)/(344+19+23+153)

# diagnostic plots
influence_plots(mod)

# multicollinearity 
vif(mod)