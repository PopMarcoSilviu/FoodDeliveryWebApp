package com.example.delivery_food_back_end.data;

import com.example.delivery_food_back_end.business.Utils;
import com.example.delivery_food_back_end.exceptions.FileAlreadyExistsException;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.Scanner;

public class CreateReport
{

    public static void createReport(List<Object> list)
    {
        try
        {
            int number = getAndUpdateNumberFromFile("src/main/resources/reports/reportStats");
            String path = "src/main/resources/reports";
            String name = "report";
            File myObj = new File(path + '/' + name + String.valueOf(number));
            if (myObj.createNewFile())
            {
                FileWriter fileWriter = new FileWriter(path + '/' + name + String.valueOf(number));
                fileWriter.write(Objects.requireNonNull(Utils.objectListToString(list)));
                fileWriter.close();
            }
            else
            {
                throw new FileAlreadyExistsException("File name exists");
            }

        } catch (IOException | FileAlreadyExistsException e )
        {
            e.printStackTrace();
        }

    }

    public static int getAndUpdateNumberFromFile(String path)
    {
        int number;
            try
            {
                File myObj = new File(path);
                Scanner scanner = new Scanner(myObj);

                if(scanner.hasNextLine())
                {
                    var line = scanner.nextLine();
                    number = Integer.parseInt(line);
                }

                else
                {
                    throw new Exception();
                }
                scanner.close();

                FileWriter fileWriter = new FileWriter(path);
                String a = String.valueOf(number+1);
                fileWriter.write(a);
                fileWriter.close();

            }
            catch (Exception e)
            {
                e.printStackTrace();
                return 0;
            }

            return number;
    }
}
