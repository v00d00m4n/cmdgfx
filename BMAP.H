// Bitmap.h

#ifndef BMAPH
#define BMAPH

#include "RGBcol.h"

struct PCXheader {     // Header f�r filer av typen PCX
	char mfacturer;      // ID-byte, 0A (10) betyder PCX
	char version;        // Version av PCX-formatet bilden sparats i
	char encoding;       // Packningsmetod, alltid 1 = R(un)L(ength)E(ncoding)
	char bit_per_pixel;  // Bitsperpixel, 8 = 256 colour, 4 = 16 cols..
	short Xmin;          // Bla bla
	short Ymin;          // Bla bla
	short Xmax;          // Max X
	short Ymax;          // Max Y
	short Hres;          // n�t med printern
	short Vres;
	char hpalette[48];   // skr�p (f�r EGA-kort)
	char reserved;       // reserverad
	char planes;         // Colour planes, 1 f�r 256c-l�ge
	short bpline;        // Bytes per horisontell linje
	short palettetype;   // ska vara 1
	char filler[58];     // reserverade/ej specifierade...
};

#define EXTRAS_NONE   0
#define EXTRAS_ARRAY  1
#define EXTRAS_BITMAP 2

typedef struct Bitmap {
	int xSize, ySize;
	unsigned char *data;
	void *extras;
	int extrasType;
	RGBcol cols[256];
	int transpVal;
	int projectionDistance; // needed in perspective correct texture mapping
	int bCmdBlock, blockRefresh;
	char pathOrBlockString[256];
	struct Bitmap *next;
} Bitmap;
	
int PCXload (Bitmap *bild,char filename[]); // only 256 color image supported
void putBitmap (int x, int y, Bitmap *bild);
void put_transparent_Bitmap (int x, int y, Bitmap *bild);
void putBitmap_scaled (int x, int y, int xrange, int yrange, Bitmap *bild);
void put_transBitmap_scaled (int x, int y, int xrange, int yrange, Bitmap *bild);
void shadeBitmap (int x, int y, Bitmap *bild, int addon);
void freeBitmap(Bitmap *bild, int bFreeBasePointer);

#endif
