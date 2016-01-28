library('tuneR')

args = commandArgs(trailingOnly=TRUE)
song_name = args[1] #'00_The-Beatles_I-Saw-Her-Standing-There'
song_path = paste('../res/mp3/', song_name, '.mp3', sep='')
track_option = 'left'

song = updateWave(mono(readMP3(song_path), track_option))

mfcc_coef = melfcc(song)
mfcc_coef[is.na(mfcc_coef)] = 0

write.table(mfcc_coef, paste('../out/mfcc/', song_name, sep=''), row.names=F, col.names=F, sep=",")
print(args[1])
