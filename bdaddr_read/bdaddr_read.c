#include <fcntl.h>
#include <string.h>
#include <cutils/properties.h>
#include <cutils/log.h>
#include <sys/stat.h>

#define LOG_TAG "bdaddr"
#define BDADDR_PATH "/data/bdaddr"

/* Read bluetooth MAC from RIL (different format),
 * write it directly to bluetoothd address
 *
 * Liberally borrowed from AOKP commit 7ff2808fc6db0601277d728eb2d933ccdbf21aea
 * via Bill Crossley
 */

int main() {
    int fd;
    char addr_from_ril[PROPERTY_VALUE_MAX];

    /*
     *Get BT Address from ril property and write to btd address
     */

    property_get("ril.bt_macaddr", addr_from_ril, "");

    if (addr_from_ril[0] == 0) {
    printf("Unable to read default bdaddr from ril.bt_macaddr, reverting to default\n");
    return -1;
    }

    printf("Read default bdaddr from ril.bt_macaddr: %s\n", addr_from_ril);
		
    //FIX ME sprintf(addr_from_ril, "%02X:%02X:%02X:%02X:%02X:%02X" herpderpderp);

    printf("Converted to formatted mac: %s\n", addr_from_ril);

    fd = open("/data/bdaddr", O_WRONLY|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR|S_IRGRP);
    if (fd < 0)
    {
    printf("Unable to open btd address, bailing\n");
    return -2;
    }
    
    write(fd, addr_from_ril, 18);
    close(fd);
    property_set("ro.bt.bdaddr_path", BDADDR_PATH);
    return (0);
}
