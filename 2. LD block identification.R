library("SelectionTools")
st.input.dir <- "input"
st.output.dir <- "output"
## SNP
st.read.marker.data("snp.geno.txt",format="m")
st.restrict.marker.data ( NoAll.MAX=2 )
st.restrict.marker.data ( MaMis.MAX=0.2 )
st.restrict.marker.data ( ExHet.MIN=0.1 )
st.restrict.marker.data ( InMis.MAX=0.3 )
st.copy.marker.data (source.data.set = "default",target.data.set = "ld.blocks")
## POS
st.read.map("snp.pos.txt", m.stretch = 1, format = "mcp", skip=1, data.set="ld.blocks")
ld <- st.calc.ld ( ld.measure="r2", data.set="ld.blocks", auxfiles = T)
head(ld)
h <- st.def.hblocks ( ld.threshold = 0.7, ld.criterion = "flanking", tolerance = 1, data.set="ld.blocks" )     
head(h)
write.table(h, file="block-list-gebv-ex.txt", sep=" ", row.names=F, quote=F)
