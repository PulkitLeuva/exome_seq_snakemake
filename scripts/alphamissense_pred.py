# This Part is to separate a single chr annotation rows.
# Because this laptop is not capable of reading the whole file at once
# Comment it out if you dont need speific chr data or want to use the whole file 
 
'''import pandas as pd

# Specify the file path
file_path = "/lustre/pulkit.h/snakemake_local/snakemake/input/alphamissense/AlphaMissense_hg19.tsv/AlphaMissense_hg19.tsv"

# Specify the chunk size based on your available memory
chunk_size = 10000

# Initialize an empty DataFrame to store the filtered results
filtered_df = pd.DataFrame()

# Iterate through chunks of the file
for chunk in pd.read_csv(file_path, sep='\t', skiprows=3, chunksize=chunk_size):
    # Filter rows where the '#CHROM' column is equal to 'chr8'
    chunk_filtered = chunk[chunk['#CHROM'] == 'chr8']
    
    # Append the filtered chunk to the results DataFrame
    filtered_df = pd.concat([filtered_df, chunk_filtered], ignore_index=True)

# Save the resulting DataFrame to a new TSV file in the current directory
filtered_df.to_csv("filtered_data_chr8.tsv", sep='\t', index=False)

# Display the resulting DataFrame
print(filtered_df)'''
################################################################################################

import pandas as pd

# Read the first DataFrame from the first file
df1 = pd.read_csv("/lustre/pulkit.h/snakemake_local/snakemake/input/alphamissense/AlphaMissense_hg19.tsv/filtered_data_chr8.tsv", sep='\t')

# Read the second DataFrame from the second file
df2 = pd.read_csv("/lustre/pulkit.h/snakemake_local/snakemake/output/father/variants/father.gatk.vcf", sep='\t',  skiprows=25)

# Merge the DataFrames on the common columns (CHROM, POS, REF, ALT)
merged_df = pd.merge(df1, df2, on=['#CHROM', 'POS', 'REF', 'ALT'])

# Save the matching rows to a new TSV file
merged_df.to_csv("/lustre/pulkit.h/snakemake_local/snakemake/output/father/variants/alphamissense/matching_rows.tsv", sep='\t', index=False)

# Display the matching rows DataFrame
print(merged_df)
