if [[ -z $1 ]]; then
    echo "Usage: call ./ebook-to-mp3.sh [YOUR-FILE]"
fi
book=$1
echo "Converting ${book} to mp3..."

ebook-convert "${book}" "${book%.*}.txt"
if [[ ! -f "${book%.*}.txt" ]]; then
    echo "Cannot convert book to txt!"
    exit
fi

espeak-ng -ven-d -f "${book%.*}.txt" -w "${book%.*}.wav"
if [[ ! -f "${book%.*}.txt" ]]; then
    echo "Cannot convert book to wav!"
    exit
fi

ffmpeg -i "${book%.*}.wav" "${book%.*}.mp3"
if [[ ! -f "${book%.*}.txt" ]]; then
    echo "Cannot convert book to mp3!"
    exit
fi

rm -f "${book%.*}.txt"
rm -f "${book%.*}.wav"

echo "Finished converting "${book%.*}.mp3""