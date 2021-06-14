package com.example.delivery_food_back_end.close.operation;

import com.example.delivery_food_back_end.business.DeliveryService;

import javax.swing.*;
import java.awt.*;

public class ServerInterface
{

    public ServerInterface()
    {
        int xSize = 600;
        int ySize = 300;
        Font font = new Font("Arial", Font.BOLD, 40);
        JFrame frame = new JFrame();
        JPanel mainPanel = new JPanel(new GridLayout(1, 2));
        JButton closeAndSaveButton = new JButton("save & close");
        JButton saveButton = new JButton("save");
        saveButton.setFont(font);
        closeAndSaveButton.setFont(font);
        closeAndSaveButton.addActionListener(e-> close());
        saveButton.addActionListener(e -> save());
        mainPanel.add(saveButton);
        mainPanel.add(closeAndSaveButton);
        frame.setSize(xSize,ySize);

        Dimension screenDimension = Toolkit.getDefaultToolkit().getScreenSize();

        frame.setLocation((screenDimension.width - xSize) / 2, (screenDimension.height - ySize) / 2);

        frame.add(mainPanel);
        frame.setVisible(true);
    }


    private void save()
    {
        DeliveryService.deliveryService.saveData();
    }

    private void close()
    {
        save();
        System.exit(0);
    }
}
