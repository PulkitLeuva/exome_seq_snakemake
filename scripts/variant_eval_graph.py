import matplotlib.pyplot as plt
import pandas as pd

# Read the relevant section of the GATK VariantEval file into a pandas DataFrame
# Replace 'your_file.txt' with the actual filename
df = pd.read_csv('/lustre/pulkit.h/snakemake_local/snakemake/output/father/qc/variants_eval/father.variant_eval.txt', sep='\t', comment='#', header=None)
print(df)
# Extract relevant columns for plotting
# Example: Extracting columns for TiTvVariantEvaluator table
ti_tv_df = df[df[0] == 'TiTvVariantEvaluator'][[1, 2, 6]]

# Plotting Ti/Tv ratio
plt.bar(ti_tv_df[1], ti_tv_df[6])
plt.xlabel('Sample')
plt.ylabel('Ti/Tv Ratio')
plt.title('Transition/Transversion Ratio for Each Sample')
plt.show()
