/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Xilinx Projects/Clock_Manager.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );


static void work_a_0218132817_3212880686_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    int t9;
    unsigned char t10;
    char *t11;
    int t12;
    int t13;
    char *t14;

LAB0:    xsi_set_current_line(31, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 3392);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(32, ng0);
    t7 = (t0 + 1968U);
    t8 = *((char **)t7);
    t9 = *((int *)t8);
    t10 = (t9 < 25000);
    if (t10 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(33, ng0);
    t2 = (t0 + 1968U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(35, ng0);
    t2 = (t0 + 2088U);
    t3 = *((char **)t2);
    t9 = *((int *)t3);
    t1 = (t9 < 1000);
    if (t1 != 0)
        goto LAB11;

LAB13:    xsi_set_current_line(36, ng0);
    t2 = (t0 + 2088U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int *)t2) = 0;
    xsi_set_current_line(37, ng0);
    t2 = (t0 + 1672U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t1);
    t2 = (t0 + 3472);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t14 = *((char **)t11);
    *((unsigned char *)t14) = t4;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(38, ng0);
    t2 = (t0 + 1672U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 3536);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t14 = *((char **)t11);
    *((unsigned char *)t14) = t1;
    xsi_driver_first_trans_fast_port(t2);

LAB12:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t4 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t1);
    t2 = (t0 + 3600);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t14 = *((char **)t11);
    *((unsigned char *)t14) = t4;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(42, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 3664);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t11 = (t8 + 56U);
    t14 = *((char **)t11);
    *((unsigned char *)t14) = t1;
    xsi_driver_first_trans_fast_port(t2);

LAB9:    goto LAB3;

LAB5:    t2 = (t0 + 992U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

LAB8:    xsi_set_current_line(32, ng0);
    t7 = (t0 + 1968U);
    t11 = *((char **)t7);
    t12 = *((int *)t11);
    t13 = (t12 + 1);
    t7 = (t0 + 1968U);
    t14 = *((char **)t7);
    t7 = (t14 + 0);
    *((int *)t7) = t13;
    goto LAB9;

LAB11:    xsi_set_current_line(35, ng0);
    t2 = (t0 + 2088U);
    t7 = *((char **)t2);
    t12 = *((int *)t7);
    t13 = (t12 + 1);
    t2 = (t0 + 2088U);
    t8 = *((char **)t2);
    t2 = (t8 + 0);
    *((int *)t2) = t13;
    goto LAB12;

}


extern void work_a_0218132817_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0218132817_3212880686_p_0};
	xsi_register_didat("work_a_0218132817_3212880686", "isim/TrafficLight_Test_isim_beh.exe.sim/work/a_0218132817_3212880686.didat");
	xsi_register_executes(pe);
}
