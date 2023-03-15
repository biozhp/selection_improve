## pi
vcftools --vcf snp.vcf --keep ./LA.txt --window-pi 200000 --window-pi-step 100000 --out ./LA.pi.txt && \
vcftools --vcf snp.vcf --keep ./MC.txt --window-pi 200000 --window-pi-step 100000 --out ./MC.pi.txt && \
## Fst
vcftools --vcf snp.vcf --weir-fst-pop ./LA.txt --weir-fst-pop ./MC.txt --fst-window-size 200000 --fst-window-step 100000 --out ./LA_MC_Fst.txt && \
## XPCLR
xpclr --out ./XPCLR/xpclr.out --format vcf --input snp.vcf --samplesA ./LA.txt --samplesB ./MC.txt --rrate 2.6e-9 --chr $line --phased --minsnps 1 --maxsnps 500 --size 200000 --step 100000
