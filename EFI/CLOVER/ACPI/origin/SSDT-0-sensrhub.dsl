/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20180427 (64-bit version)(RM)
 * Copyright (c) 2000 - 2018 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT-0-sensrhub.aml, Sat Nov  3 20:29:33 2018
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000228 (552)
 *     Revision         0x01
 *     Checksum         0xAF
 *     OEM ID           "INTEL"
 *     OEM Table ID     "sensrhub"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20120711 (538052369)
 */
DefinitionBlock ("", "SSDT", 1, "INTEL", "sensrhub", 0x00000000)
{
    /*
     * iASL Warning: There were 2 external control methods found during
     * disassembly, but only 0 were resolved (2 unresolved). Additional
     * ACPI tables may be required to properly disassemble the code. This
     * resulting disassembler output file may not compile because the
     * disassembler did not know how many arguments to assign to the
     * unresolved methods. Note: SSDTs can be dynamically loaded at
     * runtime and may or may not be available via the host OS.
     *
     * To specify the tables needed to resolve external control method
     * references, the -e option can be used to specify the filenames.
     * Example iASL invocations:
     *     iasl -e ssdt1.aml ssdt2.aml ssdt3.aml -d dsdt.aml
     *     iasl -e dsdt.aml ssdt2.aml -d ssdt1.aml
     *     iasl -e ssdt*.aml -d dsdt.aml
     *
     * In addition, the -fe option can be used to specify a file containing
     * control method external declarations with the associated method
     * argument counts. Each line of the file must be of the form:
     *     External (<method pathname>, MethodObj, <argument count>)
     * Invocation:
     *     iasl -fe refs.txt -d dsdt.aml
     *
     * The following methods were unresolved and many not compile properly
     * because the disassembler had to guess at the number of arguments
     * required for each:
     */
    External (_SB_.PCI0.I2C0.DFUD, UnknownObj)    // Warning: Unknown object
    External (_SB_.PCI0.I2C0.SHUB, UnknownObj)    // Warning: Unknown object
    External (_SB_.RDGP, MethodObj)    // Warning: Unknown method, guessing 0 arguments
    External (_SB_.WTGP, MethodObj)    // Warning: Unknown method, guessing 2 arguments
    External (SDS0, UnknownObj)    // Warning: Unknown object
    External (USBH, UnknownObj)    // Warning: Unknown object

    Scope (\)
    {
        Device (SHAD)
        {
            Name (_HID, EisaId ("INT33D0"))  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0C02"))  // _CID: Compatible ID
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (((SDS0 & One) || (USBH & One)))
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                Name (PGCE, Zero)
                Name (PGCD, Zero)
                Name (DFUE, Zero)
                Name (DFUD, Zero)
                Name (OLDV, Zero)
                Name (PGCV, Zero)
                Name (DFUV, Zero)
                If ((Arg0 == ToUUID ("03c868d5-563f-42a8-9f57-9a18d949b7cb")))
                {
                    If ((One == ToInteger (Arg1)))
                    {
                        Switch (ToInteger (Arg2))
                        {
                            Case (Zero)
                            {
                                Return (Buffer (One)
                                {
                                     0x0F                                           
                                })
                            }
                            Case (One)
                            {
                                PGCE = DerefOf (Arg3 [Zero])
                                PGCD = DerefOf (Arg3 [One])
                                0x2E = \_SB.RDGP ()
                                OLDV
                                \_SB.WTGP (0x2E, PGCE)
                                If ((PGCD > Zero))
                                {
                                    Sleep (PGCD)
                                    \_SB.WTGP (0x2E, OLDV)
                                }

                                If ((\_SB.RDGP () == 0x2E))
                                {
                                    One
                                    Sleep (0x96)
                                    If ((\_SB.RDGP () == 0x2C))
                                    {
                                        One
                                        Notify (\_SB.PCI0.I2C0.SHUB, One)
                                    }
                                    Else
                                    {
                                        Notify (\_SB.PCI0.I2C0.DFUD, One)
                                    }
                                }

                                Return (Zero)
                            }
                            Case (0x02)
                            {
                                DFUE = DerefOf (Arg3 [Zero])
                                DFUD = DerefOf (Arg3 [One])
                                0x2C = \_SB.RDGP ()
                                OLDV
                                \_SB.WTGP (0x2C, DFUE)
                                If ((DFUD > Zero))
                                {
                                    Sleep (DFUD)
                                    \_SB.WTGP (0x2C, OLDV)
                                }

                                Return (Zero)
                            }
                            Case (0x03)
                            {
                                0x2C = \_SB.RDGP ()
                                DFUV
                                0x2E = \_SB.RDGP ()
                                PGCV
                                Return (Package (0x02)
                                {
                                    PGCV, 
                                    DFUV
                                })
                            }

                        }

                        Return (Zero)
                    }

                    Return (Zero)
                }

                Return (Zero)
            }
        }
    }
}

